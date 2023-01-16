module AllCategoriesFilter
    include Liquid::StandardFilters

    def all_categories(posts)
      counts = {}

      posts.each do |post|
        post['categories'].each do |category|
          if counts[category]
            counts[category] += 1
          else
            counts[category] = 1
          end
        end
      end

      categories = counts.keys
      categories.reject { |t| t.empty? }
        .map { |category| { 'name' => category, 'count' => counts[category] } }
        .sort { |category1, category2| category2['count'] <=> category1['count'] }
    end
end

Liquid::Template.register_filter(AllCategoriesFilter)
