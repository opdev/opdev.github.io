Jekyll::Hooks.register :articles, :post_write do |article|
    all_existing_tags = Dir.entries("_tags")
        .map { |t| t.match(/(.*).md/) }
        .compact.map { |m| m[1] }

    tags = article['tags'].reject { |t| t.empty? }
    tags.each do |tag|
        generate_tag_file(tag) if !all_existing_tags.include?(tag)
    end
end

def generate_tag_file(tag)
    File.open("_tags/#{tag}.md", "wb") do |file|
        file << "---\nlayout: tagpage\ntag-name: #{tag}\npermalink: /#{tag}/\n---\n"
    end
end