#!/usr/bin/env ruby
# Read-only structural checks; does not validate external claims or render diagrams.
require 'date'
require 'json'
require 'pathname'
require 'set'
require 'uri'
require 'yaml'

root = Pathname.new(__dir__).parent.expand_path
files = Dir.glob(root.join('**/*.md')).map { |p| Pathname.new(p) }.reject do |p|
  p.relative_path_from(root).to_s.start_with?('.git/', '.obsidian/', 'Notion Import Pack/')
end
errors = []
review_queue = []
notes = {}
targets = Set.new
Dir.glob(root.join('**/*')).each do |p|
  next unless File.file?(p)
  rel = Pathname.new(p).relative_path_from(root).to_s
  targets.merge([rel, File.basename(rel)])
  targets.merge([rel.delete_suffix('.md'), File.basename(rel, '.md')]) if rel.end_with?('.md')
end

files.each do |path|
  rel = path.relative_path_from(root).to_s
  text = path.read
  metadata = {}
  body = text
  if text.start_with?("---\n")
    match = text.match(/\A---\n(.*?)\n---\n/m)
    if match
      begin
        metadata = YAML.safe_load(match[1], permitted_classes: [Date], aliases: true)
        raise 'frontmatter must be a mapping' unless metadata.is_a?(Hash)
        Array(metadata['aliases']).each { |a| targets.add(a.to_s) }
        body = text[match.end(0)..]
      rescue StandardError => e
        errors << "#{rel}: #{e.message}"
      end
    else
      errors << "#{rel}: unclosed frontmatter"
    end
  elsif rel != 'README.md'
    errors << "#{rel}: missing frontmatter"
  end
  notes[rel] = {metadata: metadata, body: body}
end

stats = {vault_notes: notes.size - (notes.key?('README.md') ? 1 : 0),
         technical_roles: 0, nontechnical_roles: 0, studio_cases: 0,
         flashcards: 0, notes_with_checks: 0, mermaid_diagrams: 0,
         notes_with_mermaid: 0, overdue_reviews: 0}

notes.each do |rel, note|
  stats[:technical_roles] += 1 if rel.start_with?('04 Role Tracks/Technical/')
  stats[:nontechnical_roles] += 1 if rel.start_with?('04 Role Tracks/Nontechnical/')
  stats[:studio_cases] += 1 if rel.start_with?('12 Technical Studio/Case - ')
  review = note[:metadata]['review_by']
  begin
    if review && Date.parse(review.to_s) < Date.today
      stats[:overdue_reviews] += 1
      review_queue << {note: rel, review_by: review.to_s}
    end
  rescue ArgumentError
    errors << "#{rel}: invalid review_by date"
  end
  fence = nil
  lines = []
  has_diagram = false
  note[:body].each_line.with_index(1) do |line, index|
    match = line.match(/^\s{0,3}(`{3,}|~{3,})(.*)$/)
    if match
      marker, info = match.captures
      if fence
        fence = nil if marker[0] == fence[0] && marker.length >= fence.length && info.strip.empty?
      else
        fence = marker
        if info.strip == 'mermaid'
          stats[:mermaid_diagrams] += 1
          has_diagram = true
        end
      end
      next
    end
    next if fence
    lines << line
    if rel != 'README.md' && line.match?(/^[^\s#>|`].*?::\s*\S/) && !line.include?('`::')
      stats[:flashcards] += 1
    end
  end
  errors << "#{rel}: unclosed code fence" if fence
  stats[:notes_with_mermaid] += 1 if has_diagram
  plain = lines.join.gsub(/%%.*?%%/m, '').gsub(/`[^`]*`/, '')
  stats[:notes_with_checks] += 1 if plain.match?(/^\#{1,6} .*?(?:quiz|knowledge check|cumulative check)/i)
  plain.scan(/!?\[\[([^\]]+)\]\]/).each do |capture|
    target = capture[0].split('|').first.to_s.split('#').first.to_s.strip
    next if target.empty? || targets.include?(target)
    candidate = root.join(File.dirname(rel), target).cleanpath
    next if candidate.file? || Pathname.new(candidate.to_s + '.md').file?
    errors << "#{rel}: unresolved wikilink #{target}"
  end
  # Standard Markdown local paths (including angle-wrapped spaces), not remote URLs.
  plain.scan(/!?\[[^\]\n]*\]\((<[^>]+>|[^)\s]+)(?:\s+"[^"]*")?\)/).each do |capture|
    raw = capture[0].delete_prefix('<').delete_suffix('>')
    next if raw.match?(/\A(?:[a-z][a-z0-9+.-]*:|#)/i)
    target = URI::DEFAULT_PARSER.unescape(raw.split('#').first.to_s)
    next if target.empty?
    candidate = root.join(File.dirname(rel), target).cleanpath
    errors << "#{rel}: missing local Markdown target #{target}" unless candidate.exist?
  end
end
stats[:role_tracks] = stats[:technical_roles] + stats[:nontechnical_roles]
stats[:scope] = 'Structural validation only; flashcards count non-code question::answer lines; checks count explicit quiz/knowledge-check headings.'
puts JSON.pretty_generate({stats: stats, overdue_review_queue: review_queue, errors: errors.uniq})
exit(errors.empty? ? 0 : 1)
