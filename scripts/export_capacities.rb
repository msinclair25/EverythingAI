#!/usr/bin/env ruby
# Build Capacities desktop bulk-import ZIPs from the Obsidian source vault.
require "date"
require "fileutils"
require "json"
require "pathname"
require "tmpdir"
require "yaml"

ROOT = Pathname.new(__dir__).parent.expand_path
AS_OF = Date.parse(ENV.fetch("CAPACITIES_AS_OF", Date.today.iso8601))
LIMIT = 100 # Capacities' documented maximum importable files per bulk import.
PACKS = {
  "1 Learning and Career Map" => %w[00 01 02 03],
  "2 Role Tracks" => %w[04],
  "3 Tools and Technical Studio" => %w[05 12],
  "4 Practice Research and Visuals" => %w[06 07 08 09 10 11]
}.freeze
IMAGE_EXTENSIONS = %w[.png .jpg .jpeg .gif .webp .svg].freeze

def source_paths
  Dir.glob(ROOT.join("**/*.md")).map { |name| Pathname.new(name) }.reject do |path|
    rel = path.relative_path_from(ROOT).to_s
    rel == "README.md" || rel.start_with?(".git/", ".obsidian/", "Notion Import Pack/", "Capacities Import Pack/")
  end.sort_by { |path| path.relative_path_from(ROOT).to_s }
end

def split_frontmatter(text, rel)
  match = text.match(/\A---\r?\n(.*?)\r?\n---\r?\n/m)
  raise "Missing or unclosed frontmatter: #{rel}" unless match

  data = YAML.safe_load(match[1], permitted_classes: [Date], aliases: true)
  raise "Frontmatter is not a mapping: #{rel}" unless data.is_a?(Hash)

  [data, text[match.end(0)..]]
end

def title_for(path, data)
  value = data["title"]
  value.is_a?(String) && !value.empty? ? value : path.basename(".md").to_s
end

def object_type(rel, data)
  return "Role" if rel.start_with?("04 Role Tracks/")
  return "Case" if rel.start_with?("12 Technical Studio/Case - ") || data["type"] == "case"
  return "Concept" if rel.match?(%r{\A(?:01 Foundations|02 Core Skills)/}) || rel.start_with?("12 Technical Studio/")
  return "Tool" if rel.start_with?("05 Tool Atlas/")
  return "Research" if rel.start_with?("10 Research/")

  "Page"
end

def pack_for(rel)
  return PACKS.keys.first unless rel.include?("/")

  prefix = rel.split("/", 2).first[0, 2]
  PACKS.find { |_name, prefixes| prefixes.include?(prefix) }&.first ||
    raise("No Capacities pack for #{rel}")
end

def metadata_for(paths)
  paths.to_h do |path|
    rel = path.relative_path_from(ROOT).to_s
    data, body = split_frontmatter(path.read, rel)
    [rel, {path: path, data: data, body: body, title: title_for(path, data)}]
  end
end

def lookup_for(notes)
  lookup = Hash.new { |hash, key| hash[key] = [] }
  notes.each do |rel, note|
    keys = [rel.delete_suffix(".md"), File.basename(rel, ".md"), note[:title]] + Array(note[:data]["aliases"])
    keys.each { |key| lookup[key.to_s] << rel }
  end
  lookup
end

def resolve_note(raw, lookup)
  key = raw.sub(/\.md\z/i, "").sub(%r{\A\./}, "")
  matches = lookup[key].uniq
  matches = lookup[File.basename(key)].uniq if matches.empty?
  matches.length == 1 ? matches.first : nil
end

def source_url(rel)
  escaped = rel.split("/").map { |part| part.bytes.map { |byte|
    byte.chr.match?(/[A-Za-z0-9._~-]/) ? byte.chr : format("%%%02X", byte)
  }.join }.join("/")
  "https://github.com/msinclair25/EverythingAI/blob/main/#{escaped}"
end

def transform_body(body, rel, notes, lookup, assets)
  body = body.gsub(/%%.*?%%/m, "")
  output = []
  fence = nil
  body.each_line do |line|
    match = line.match(/^\s{0,3}(`{3,}|~{3,})(.*)$/)
    if match
      marker, info = match.captures
      if fence && marker[0] == fence[0] && marker.length >= fence.length && info.strip.empty?
        fence = nil
      elsif fence.nil?
        fence = marker
      end
      output << line
      next
    end
    if fence
      output << line
      next
    end

    line = line.gsub(/^> \[!([A-Za-z0-9_-]+)\][+-]?\s*(.*)$/) do
      label = Regexp.last_match(2).strip
      label = Regexp.last_match(1).capitalize if label.empty?
      "> **#{label}:**"
    end
    line = line.gsub(/==([^=\n]+)==/, '**\\1**')
    line = line.gsub(/!?\[\[([^\]]+)\]\]/) do
      original = Regexp.last_match(0)
      target, display = Regexp.last_match(1).split("|", 2)
      target = target.strip
      if target.start_with?("#")
        display || target.delete_prefix("#")
      elsif target.match?(/\.base(?:#.*)?\z/i)
        title = target.include?("Role Explorer") ? "Capacities Role Explorer" : "Capacities Source Review"
        "[[#{title}]]"
      elsif target.match?(/\.canvas(?:#.*)?\z/i)
        "[[Capacities Visual Map]]"
      elsif IMAGE_EXTENSIONS.include?(File.extname(target.downcase))
        image = assets[target] || assets[File.basename(target)]
        if image
          relative = Pathname.new(image).relative_path_from(Pathname.new(rel).dirname).to_s
          "![#{display || File.basename(image)}](#{relative})"
        else
          original
        end
      else
        name, anchor = target.split("#", 2)
        resolved = resolve_note(name, lookup)
        if resolved
          label = notes.fetch(resolved)[:title]
          anchor && !anchor.empty? ? "[[#{label}]] (#{anchor})" : "[[#{label}]]"
        else
          original
        end
      end
    end
    line = line.gsub(/\s+\^[A-Za-z0-9_-]+\s*$/, "\n")
    line = line.gsub(/\[([^\]]+)\]\(<[^>]+\.(?:zip|rb)>\)/i, '\\1')
    next if line.start_with?("HTML fallback (")
    output << line
  end
  raise "Unclosed code fence: #{rel}" if fence

  output.join.strip + "\n"
end

def converted_note(rel, note, notes, lookup, assets)
  data = note[:data]
  type = object_type(rel, data)
  metadata = {
    "title" => note[:title],
    "type" => type,
    "tags" => Array(data["tags"]).join(", "),
    "source_path" => rel,
    "source_type" => data["type"].to_s,
    "scope" => data["scope"].to_s,
    "level" => Array(data["level"]).join(", "),
    "last_verified" => (data["last_verified"] || data["as_of"]).to_s,
    "review_by" => data["review_by"].to_s
  }.reject { |_key, value| value.empty? }
  body = transform_body(note[:body], rel, notes, lookup, assets)
  record = ["[Vault source](#{source_url(rel)})"]
  record << "last verified #{metadata['last_verified']}" if metadata["last_verified"]
  record << "review by #{metadata['review_by']}" if metadata["review_by"]
  body = body.sub(/\A(#[^\n]*\n)/, "\\1\n> **Source record:** #{record.join(' · ')}.\n")
  "#{YAML.dump(metadata)}---\n\n#{body}"
end

def generated_page(title, type, body)
  "#{YAML.dump({"title" => title, "type" => type, "tags" => "everything-ai, import-directory"})}---\n\n# #{title}\n\n#{body.strip}\n"
end

def role_index(notes)
  rows = notes.select { |rel, _| rel.start_with?("04 Role Tracks/") }.map do |rel, note|
    [note[:data]["family"].to_s, note[:title], rel]
  end.sort
  lines = ["Use this directory to find a role after importing Pack 2.", "", "| Family | Role |", "|---|---|"]
  rows.each { |family, title, _rel| lines << "| #{family} | [[#{title}]] |" }
  generated_page("Capacities Role Explorer", "Page", lines.join("\n"))
end

def review_index(notes)
  rows = notes.map do |rel, note|
    date = note[:data]["review_by"]
    next if date.nil? || Date.parse(date.to_s) > AS_OF

    [date.to_s, note[:title], rel]
  rescue ArgumentError
    nil
  end.compact.sort
  lines = ["Static review queue generated #{AS_OF}. Rebuild the export after vault updates.", "", "| Review by | Note |", "|---|---|"]
  rows.each { |date, title, _rel| lines << "| #{date} | [[#{title}]] |" }
  generated_page("Capacities Source Review", "Page", lines.join("\n"))
end

def visual_map
  canvas = ROOT.join("11 Visual Maps/AI Career Landscape.canvas")
  data = JSON.parse(canvas.read)
  lines = ["Readable index of the Obsidian AI Career Landscape Canvas.", ""]
  data.fetch("nodes", []).each do |node|
    if node["file"]
      lines << "- [[#{File.basename(node['file'], '.md')}]]"
    elsif node["text"]
      lines << "- #{node['text'].gsub(/\s+/, ' ').strip}"
    end
  end
  generated_page("Capacities Visual Map", "Page", lines.uniq.join("\n"))
end

def write(root, rel, content)
  dest = root.join(rel)
  FileUtils.mkdir_p(dest.dirname)
  File.write(dest, content)
end

paths = source_paths
notes = metadata_for(paths)
lookup = lookup_for(notes)
assets = {}
Dir.glob(ROOT.join("11 Visual Maps/*")).each do |name|
  next unless IMAGE_EXTENSIONS.include?(File.extname(name).downcase)

  rel = Pathname.new(name).relative_path_from(ROOT).to_s
  assets[rel] = rel
  assets[File.basename(rel)] = rel
end

raise "Duplicate note titles" if notes.values.map { |note| note[:title] }.uniq.size != notes.size
raise "Expected Capacities Import Guide.md" unless notes.key?("Capacities Import Guide.md")

Dir.mktmpdir("everything-ai-capacities-") do |temporary|
  build_root = Pathname.new(temporary)
  PACKS.each do |name, _prefixes|
    pack = build_root.join(name)
    FileUtils.mkdir_p(pack)
    selected = notes.select { |rel, _| pack_for(rel) == name }
    selected.each do |rel, note|
      write(pack, rel, converted_note(rel, note, notes, lookup, assets))
    end
    case name[0]
    when "2" then write(pack, "03 Career Map/Capacities Role Explorer.md", role_index(notes))
    when "4"
      write(pack, "10 Research/Capacities Source Review.md", review_index(notes))
      write(pack, "11 Visual Maps/Capacities Visual Map.md", visual_map)
      assets.values.uniq.each do |rel|
        dest = pack.join(rel)
        FileUtils.mkdir_p(dest.dirname)
        FileUtils.cp(ROOT.join(rel), dest)
      end
    end
    entries = Dir.glob(pack.join("**/*")).count { |path| File.file?(path) }
    raise "#{name} contains #{entries} files (limit #{LIMIT})" if entries > LIMIT

    output = ROOT.join("Capacities Import Pack - #{name}.zip")
    FileUtils.rm_f(output)
    Dir.chdir(pack) { raise "ZIP failed for #{name}" unless system("zip", "-qr", output.to_s, ".") }
    puts "#{output.basename}: #{entries} files (#{selected.size} vault notes)"
  end
end

puts "Source notes: #{notes.size}; generated directories: 3; visual assets: #{assets.values.uniq.size}"
