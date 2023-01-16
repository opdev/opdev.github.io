Jekyll::Hooks.register :posts, :post_write do |post|
    all_existing_categories = Dir.entries("_categories")
        .map { |t| t.match(/(.*).md/) }
        .compact.map { |m| m[1] }

    categories = post['categories'].reject { |t| t.empty? }
    categories.each do |category|
        generate_category_file(category) if !all_existing_categories.include?(category)
    end
end

def generate_category_file(category)
    File.open("_categories/#{category}.md", "wb") do |file|
        file << "---\nlayout: categorypage\ncategory-name: #{category}\npermalink: /#{category}/\n---\n"
    end
end
