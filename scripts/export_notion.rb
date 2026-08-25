#!/usr/bin/env ruby

# Generate a Notion-friendly derivative of the Everything AI Obsidian vault.
# The Obsidian vault remains the source of truth.

require "csv"
require "date"
require "fileutils"
require "json"
require "pathname"
require "tmpdir"
require "uri"
require "yaml"

ROOT = Pathname.new(__dir__).parent.expand_path
AS_OF = Date.parse(ENV.fetch("NOTION_AS_OF", "2026-08-25"))
FENCE = 96.chr * 3

PARTS = {
  "Part 1 - Core Learning" => ["00 Start Here", "01 Foundations", "02 Core Skills", "03 Career Map"],
  "Part 2 - Roles and Practice" => ["04 Role Tracks", "06 Assessment Center", "07 Interview and Portfolio", "08 Industry Overlays"],
  "Part 3 - Tools, Research, and Studio" => ["05 Tool Atlas", "09 Templates", "10 Research", "11 Visual Maps", "12 Technical Studio"]
}.freeze

ASSET_EXTENSIONS = %w[.png .jpg .jpeg .gif .webp .svg .avif].freeze

def source_files
  Dir.glob(ROOT.join("**/*.md").to_s).map { |path| Pathname.new(path) }.select do |path|
    rel = path.relative_path_from(ROOT).to_s
    !rel.start_with?(".obsidian/", ".git/", "Notion Import Pack/") && rel != "README.md"
  end.sort_by { |path| path.relative_path_from(ROOT).to_s }
end

def asset_files
  Dir.glob(ROOT.join("**/*").to_s).map { |path| Pathname.new(path) }.select do |path|
    rel = path.relative_path_from(ROOT).to_s
    path.file? &&
      ASSET_EXTENSIONS.include?(path.extname.downcase) &&
      !rel.start_with?(".obsidian/", ".git/", "Notion Import Pack/", "assets/")
  end.sort_by { |path| path.relative_path_from(ROOT).to_s }
end

def split_frontmatter(text)
  return [{}, text] unless text.start_with?("---\n")

  parts = text.split("\n---\n", 2)
  return [{}, text] unless parts.length == 2

  data = YAML.safe_load(
    parts[0].sub(/\A---\n/, ""),
    aliases: true,
    permitted_classes: [Date]
  )
  [data.is_a?(Hash) ? data : {}, parts[1]]
rescue StandardError
  [{}, text]
end

def scalar(value)
  case value
  when Array
    value.map { |item| scalar(item) }.join(", ")
  when Hash
    value.map { |key, item| "#{key}: #{scalar(item)}" }.join("; ")
  else
    value.to_s
  end
end

def note_title(path, data, body)
  return scalar(data["title"]) unless data["title"].nil?

  heading = body.lines.find { |line| line.match?(/\A#\s+/) }
  heading ? heading.sub(/\A#\s+/, "").strip : path.basename(".md").to_s
end

def metadata_lines(data)
  pairs = [
    ["Scope", data["scope"]],
    ["Level", data["level"]],
    ["Status", data["status"]],
    ["Verified", data["last_verified"] || data["as_of"]],
    ["Review by", data["review_by"]],
    ["Type", data["type"]]
  ].reject { |_label, value| value.nil? || value.to_s.empty? }

  tags = data["tags"]
  aliases = data["aliases"]
  lines = []
  lines << "> **Metadata:** #{pairs.map { |label, value| "#{label}: #{scalar(value)}" }.join(" · ")}" unless pairs.empty?
  lines << "> **Tags:** #{scalar(tags)}" if tags.is_a?(Array) && !tags.empty?
  lines << "> **Aliases:** #{scalar(aliases)}" if aliases.is_a?(Array) && !aliases.empty?
  lines
end

def stash_fenced_blocks(text)
  blocks = []
  output = []
  current = []
  marker = nil
  token = nil

  text.lines.each do |line|
    starts_with_tilde = line.match?(/\A\s*~~~/)
    starts_with_fence = line.start_with?(FENCE)
    if marker.nil? && (starts_with_tilde || starts_with_fence)
      marker = starts_with_tilde ? "~~~" : FENCE
      current = [line]
      token = "__NOTION_FENCED_BLOCK_#{blocks.length}__"
    elsif marker && line.match?(/\A\s*#{Regexp.escape(marker)}\s*\z/)
      current << line
      blocks << current.join
      output << "#{token}\n"
      current = []
      marker = nil
      token = nil
    elsif marker
      current << line
    else
      output << line
    end
  end

  unless marker.nil?
    blocks << current.join
    output << "#{token}\n"
  end

  [output.join, blocks]
end

def stash_inline_code(text)
  tick = 96.chr
  blocks = []
  pattern = /#{Regexp.escape(tick)}([^#{Regexp.escape(tick)}\n]+)#{Regexp.escape(tick)}/
  output = text.gsub(pattern) do
    token = "__NOTION_INLINE_CODE_#{blocks.length}__"
    blocks << "#{tick}#{$1}#{tick}"
    token
  end
  [output, blocks]
end

def restore_inline_code(text, blocks)
  blocks.each_with_index.reduce(text) do |result, (_block, index)|
    result.gsub("__NOTION_INLINE_CODE_#{index}__", blocks[index])
  end
end

def standardize_fences(block)
  block.lines.map do |line|
    line.sub(/\A(\s*)~~~/, "\\1#{FENCE}")
  end.join
end

def restore_fenced_blocks(text, blocks)
  blocks.each_with_index.reduce(text) do |result, (block, index)|
    result.gsub("__NOTION_FENCED_BLOCK_#{index}__", standardize_fences(block))
  end
end

def normalized_key(value)
  value.to_s.sub(/\A\.\//, "").sub(/\.md\z/i, "")
end

def build_note_lookup(files)
  lookup = Hash.new { |hash, key| hash[key] = [] }
  files.each do |path|
    rel = path.relative_path_from(ROOT).to_s
    key = normalized_key(rel)
    lookup[key] << rel
    lookup[File.basename(key)] << rel
    data, = split_frontmatter(File.read(path))
    Array(data["aliases"]).each { |alias_name| lookup[normalized_key(alias_name)] << rel }
  end
  lookup
end

def build_asset_lookup(files)
  lookup = Hash.new { |hash, key| hash[key] = [] }
  files.each do |path|
    rel = path.relative_path_from(ROOT).to_s
    lookup[rel] << rel
    lookup[path.basename.to_s] << rel
  end
  lookup
end

def resolve_note(raw_target, lookup)
  target = raw_target.to_s.strip
  return [nil, target.sub(/\A#/, "")] if target.start_with?("#")

  anchor = nil
  if target.include?("#")
    target, anchor = target.split("#", 2)
  elsif target.include?("^")
    target, anchor = target.split("^", 2)
  end

  key = normalized_key(target)
  rel = lookup[key].first || lookup[File.basename(key)].first
  [rel, anchor]
end

def escaped_path(path)
  path.split("/").map { |segment| URI::DEFAULT_PARSER.escape(segment, /[^A-Za-z0-9._~-]/) }.join("/")
end

def relative_markdown_path(current_rel, target_rel)
  from_dir = Pathname.new(current_rel).dirname
  relative = Pathname.new(target_rel).relative_path_from(from_dir).to_s
  "<#{escaped_path(relative)}>"
end

def label_for(target, display, resolved_rel, anchor)
  return display unless display.nil? || display.empty?

  label = resolved_rel ? File.basename(resolved_rel, ".md") : target
  anchor && !anchor.empty? ? "#{label} — #{anchor}" : label
end

def generated_page_for_base(target)
  case target
  when /Role Explorer\.base/i
    "Notion Index - Role Explorer.md"
  when /Source Review\.base/i
    "Notion Index - Source Review.md"
  end
end

def replace_embeds(text, current_rel, note_lookup, asset_lookup)
  text.gsub(/!\[\[([^\]]+)\]\]/) do
    raw = Regexp.last_match(1)
    target = raw.split("|", 2).first.strip

    generated = generated_page_for_base(target)
    if generated
      "[#{generated.sub(/\.md\z/, "")}](#{relative_markdown_path(current_rel, generated)})"
    elsif asset_lookup[target].any? || asset_lookup[File.basename(target)].any?
      asset_rel = asset_lookup[target].first || asset_lookup[File.basename(target)].first
      label = File.basename(asset_rel)
      "![#{label}](#{relative_markdown_path(current_rel, asset_rel)})"
    else
      resolved_rel, anchor = resolve_note(target, note_lookup)
      label = label_for(target, nil, resolved_rel, anchor)
      if resolved_rel
        "**Embedded note:** [#{label}](#{relative_markdown_path(current_rel, resolved_rel)})"
      else
        "**Embedded content:** #{label}"
      end
    end
  end
end

def replace_wikilinks(text, current_rel, note_lookup)
  text.gsub(/\[\[([^\]]+)\]\]/) do
    raw = Regexp.last_match(1)
    target, display = raw.split("|", 2)
    target = target.to_s.strip
    resolved_rel, anchor = resolve_note(target, note_lookup)
    label = label_for(target, display&.strip, resolved_rel, anchor)

    if resolved_rel
      "[#{label}](#{relative_markdown_path(current_rel, resolved_rel)})"
    else
      label
    end
  end
end

def convert_callout_headers(text)
  titles = {
    "abstract" => "Overview",
    "warning" => "Warning",
    "info" => "Information",
    "tip" => "Tip",
    "question" => "Question",
    "success" => "Success",
    "danger" => "Danger",
    "failure" => "Failure",
    "source" => "Source",
    "tool" => "Tool",
    "level" => "Level",
    "checkpoint" => "Checkpoint",
    "note" => "Note",
    "example" => "Example"
  }

  text.gsub(/^> \[!([A-Za-z0-9_-]+)\]([+-])?\s*(.*)$/) do
    type = Regexp.last_match(1).downcase
    custom = Regexp.last_match(3).to_s.strip
    title = custom.empty? ? (titles[type] || type.capitalize) : custom
    "> **#{title}**"
  end
end

def insert_metadata(body, data, title)
  lines = body.lines
  heading_index = lines.index { |line| line.match?(/\A#\s+/) }
  return "# #{title}\n\n#{metadata_lines(data).join("\n")}\n\n#{body}" if heading_index.nil?

  metadata = metadata_lines(data)
  return body if metadata.empty?

  heading = lines[0..heading_index].join.rstrip
  remainder = lines[(heading_index + 1)..]&.join.to_s.lstrip
  "#{heading}\n\n#{metadata.join("\n")}\n\n#{remainder}"
end

def strip_non_import_links(text)
  text.gsub(/\[([^\]]+)\]\(<([^>]+\.(?:zip|rb))>\)/i) { Regexp.last_match(1) }
end

def convert_markdown(path, current_rel, note_lookup, asset_lookup)
  data, body = split_frontmatter(File.read(path))
  title = note_title(path, data, body)
  body, fenced_blocks = stash_fenced_blocks(body)
  body, inline_blocks = stash_inline_code(body)
  body = body.gsub(/%%.*?%%/m, "")
  body = body.lines.reject { |line| line.match?(/\A\s*\^[A-Za-z0-9_-]+\s*\z/) }.join
  body = body.gsub(/==([^=\n]+)==/, "**\\1**")
  body = convert_callout_headers(body)
  body = replace_embeds(body, current_rel, note_lookup, asset_lookup)
  body = replace_wikilinks(body, current_rel, note_lookup)
  body = strip_non_import_links(body)
  body = restore_inline_code(body, inline_blocks)
  body = restore_fenced_blocks(body, fenced_blocks)
  body = body.gsub(/\n{3,}/, "\n\n").strip
  body = insert_metadata(body, data, title).strip
  ["#{body}\n", data, title]
end

def selected?(rel, prefixes)
  prefixes.nil? || prefixes.any? { |prefix| rel == prefix || rel.start_with?("#{prefix}/") }
end

def link_from_root(target_rel)
  "<#{escaped_path(target_rel)}>"
end

def read_data(path)
  data, = split_frontmatter(File.read(path))
  data
end

def write_file(root, rel, content)
  output = root.join(rel)
  FileUtils.mkdir_p(output.dirname)
  File.write(output, content)
end

def role_index(source_paths, note_lookup)
  rows = source_paths.select { |path| path.to_s.include?("/04 Role Tracks/") }.map do |path|
    rel = path.relative_path_from(ROOT).to_s
    data = read_data(path)
    title = scalar(data["title"])
    title = File.basename(rel, ".md") if title.empty?
    [scalar(data["family"]), title, rel]
  end.sort_by { |family, title, _rel| [family, title] }

  lines = [
    "# Role Explorer",
    "",
    "> This is the static Notion equivalent of the Obsidian Role Explorer Base. Import the Markdown pages first, then use this page as the role directory.",
    "",
    "| Role | Family | Page |",
    "|---|---|---|"
  ]
  rows.each do |family, title, rel|
    lines << "| #{title} | #{family} | [Open role](#{relative_markdown_path("Notion Index - Role Explorer.md", rel)}) |"
  end
  "#{lines.join("\n")}\n"
end

def source_review_index(source_paths)
  rows = source_paths.map do |path|
    data = read_data(path)
    review = data["review_by"]
    next if review.nil?

    review_date = begin
      Date.parse(review.to_s)
    rescue StandardError
      nil
    end
    next if review_date.nil? || review_date > AS_OF

    rel = path.relative_path_from(ROOT).to_s
    [
      scalar(data["title"]).then { |value| value.empty? ? File.basename(rel, ".md") : value },
      scalar(data["type"]),
      scalar(data["last_verified"] || data["as_of"]),
      review_date.to_s,
      scalar(data["status"]),
      rel
    ]
  end.compact.sort_by { |_title, _type, _verified, review, _status, _rel| review }

  lines = [
    "# Source Review Queue",
    "",
    "> Static snapshot generated #{AS_OF}. The Obsidian Base remains the live review queue.",
    "",
    "| Note | Type | Last verified | Review by | Status |",
    "|---|---|---|---|---|"
  ]
  rows.each do |title, type, verified, review, status, rel|
    lines << "| [#{title}](#{relative_markdown_path("Notion Index - Source Review.md", rel)}) | #{type} | #{verified} | #{review} | #{status} |"
  end
  "#{lines.join("\n")}\n"
end

def visual_map_page(note_lookup)
  canvas_path = ROOT.join("11 Visual Maps/AI Career Landscape.canvas")
  return nil unless canvas_path.file?

  data = JSON.parse(File.read(canvas_path))
  lines = [
    "# AI Career Landscape",
    "",
    "> Static Markdown replacement for the Obsidian Canvas. Use the linked role and hub pages after import.",
    ""
  ]
  data.fetch("nodes", []).each do |node|
    content = node["text"]
    content = "# #{File.basename(node["file"], ".md")}" if content.nil? && node["file"]
    next if content.nil? || content.strip.empty?

    lines << replace_wikilinks(content, "11 Visual Maps/Notion Visual Map.md", note_lookup).strip
    lines << ""
  end
  "#{lines.join("\n").strip}\n"
rescue JSON::ParserError
  nil
end

def catalog_csv(source_paths)
  CSV.generate do |csv|
    csv << ["Title", "Folder", "Path", "Type", "Scope", "Level", "Status", "Last verified", "Review by", "Tags"]
    source_paths.each do |path|
      rel = path.relative_path_from(ROOT).to_s
      data = read_data(path)
      title = scalar(data["title"])
      title = File.basename(rel, ".md") if title.empty?
      csv << [
        title,
        File.dirname(rel),
        rel,
        scalar(data["type"]),
        scalar(data["scope"]),
        scalar(data["level"]),
        scalar(data["status"]),
        scalar(data["last_verified"] || data["as_of"]),
        scalar(data["review_by"]),
        scalar(data["tags"])
      ]
    end
  end
end

def readme(pack_name, part_number, part_count, include_role, include_source)
  lines = [
    "# Everything AI — Notion import",
    "",
    "Generated #{AS_OF} from the Obsidian vault. The Obsidian vault remains the source of truth.",
    "",
    "**Pack:** #{pack_name}"
  ]
  lines << "**Import set:** Part #{part_number} of #{part_count}. Import all parts to restore the full cross-link graph." if part_number
  lines += [
    "",
    "## Start here",
    "",
    "- [Everything AI Home](#{link_from_root("00 Start Here/Everything AI - Home.md")})",
    "- [Note catalog database](Notion%20Note%20Catalog.csv)",
    "",
    "## Import",
    "",
    "1. In Notion, open Settings → Import → ZIP, or use the /zip command.",
    "2. Upload this ZIP and choose Convert Zip to pages.",
    "3. Import the CSV separately if you want a searchable Notion database of notes.",
    "4. Open Everything AI Home and use the linked route. Notion does not preserve Obsidian Bases, Canvas files, or anchor links, so static replacements are included.",
    "",
    "## Known differences",
    "",
    "- Wikilinks become ordinary Markdown links; heading anchors become page links or readable text.",
    "- Obsidian callouts become bold-labeled Markdown blockquotes.",
    "- Mermaid diagrams remain Mermaid code blocks. Render them separately or replace them with Notion images if you want visual diagrams.",
    "- Bases become static Role Explorer and Source Review pages.",
    "- Canvas becomes a linked Markdown landscape page.",
    "- CSS, frontmatter, comments, and Obsidian-only embeds are converted or omitted.",
    ""
  ]
  insert_at = lines.index { |line| line == "- [Note catalog database](Notion%20Note%20Catalog.csv)" } + 1
  lines.insert(insert_at, "- [Role Explorer](Notion%20Index%20-%20Role%20Explorer.md)") if include_role
  insert_at += 1 if include_role
  lines.insert(insert_at, "- [Source Review Queue](Notion%20Index%20-%20Source%20Review.md)") if include_source
  "#{lines.join("\n")}\n"
end

def build_pack(build_dir, pack_name, source_paths, all_source_paths, note_lookup, asset_lookup, part_number: nil, part_count: nil)
  FileUtils.mkdir_p(build_dir)
  source_paths.each do |path|
    rel = path.relative_path_from(ROOT).to_s
    converted, = convert_markdown(path, rel, note_lookup, asset_lookup)
    write_file(build_dir, rel, converted)
  end

  asset_files.each do |asset|
    rel = asset.relative_path_from(ROOT).to_s
    output = build_dir.join(rel)
    FileUtils.mkdir_p(output.dirname)
    FileUtils.cp(asset, output)
  end

  include_role = source_paths.any? { |path| path.to_s.include?("/04 Role Tracks/") }
  include_source = source_paths.any? { |path| path.to_s.include?("/10 Research/") }
  write_file(build_dir, "README.md", readme(pack_name, part_number, part_count, include_role, include_source))
  if include_role
    write_file(build_dir, "Notion Index - Role Explorer.md", role_index(all_source_paths, note_lookup))
  end
  if include_source
    write_file(build_dir, "Notion Index - Source Review.md", source_review_index(all_source_paths))
  end
  visual_map = visual_map_page(note_lookup)
  if visual_map && source_paths.any? { |path| path.to_s.include?("/11 Visual Maps/") }
    write_file(build_dir, "11 Visual Maps/Notion Visual Map.md", visual_map)
  end
  write_file(build_dir, "Notion Note Catalog.csv", catalog_csv(source_paths))
end

def zip_directory(source_dir, destination)
  FileUtils.rm_f(destination)
  Dir.chdir(source_dir) do
    success = system("zip", "-qr", destination.to_s, ".")
    abort "zip command failed for #{destination}" unless success
  end
end

files = source_files
notes_lookup = build_note_lookup(files)
assets_lookup = build_asset_lookup(asset_files)

Dir.mktmpdir("everything-ai-notion-") do |tmp|
  tmp_root = Pathname.new(tmp)

  full_dir = tmp_root.join("full")
  build_pack(full_dir, "Full vault", files, files, notes_lookup, assets_lookup)
  zip_directory(full_dir, ROOT.join("Notion Import Pack.zip"))

  PARTS.each_with_index do |(part_name, prefixes), index|
    selected = files.select { |path| selected?(path.relative_path_from(ROOT).to_s, prefixes) }
    guide = ROOT.join("Notion Import Guide.md")
    selected << guide if guide.file? && !selected.include?(guide)
    part_dir = tmp_root.join("part-#{index + 1}")
    build_pack(
      part_dir,
      part_name,
      selected,
      files,
      notes_lookup,
      assets_lookup,
      part_number: index + 1,
      part_count: PARTS.length
    )
    zip_name = "Notion Import Pack - Part #{index + 1} #{part_name.sub(/\APart \d+ - /, "")}.zip"
    zip_directory(part_dir, ROOT.join(zip_name))
  end
end

puts "Notion export complete"
puts "Source notes: #{files.length}"
puts "Assets: #{asset_files.length}"
puts "Full pack: #{ROOT.join("Notion Import Pack.zip")}"
puts "Split packs: #{PARTS.length}"
