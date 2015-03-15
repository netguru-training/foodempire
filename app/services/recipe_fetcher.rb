require 'open-uri'
require 'json'

class RecipeFetcher
  URL = 'http://www.recipepuppy.com/api/?p='

  attr_reader :page, :limit

  def initialize(page = 0, limit = 0)
    @page = page
    @limit = limit
  end

  def self.call(page = 0, limit = 0)
    new(page, limit).call
  end

  def call
    results = fetch
    results.each do |result|
      ingredients = result['ingredients'].split(', ')
      ingriedents_for_recipe = []
      ingredients.each do |ingredient|
        ingriedents_for_recipe << Ingredient.find_or_create_by(name: ingredient)
      end
      Recipe.create(name: result['title'], recipe_url: result['href'], picture_url: result['thumbnail'], ingredients: ingriedents_for_recipe)
    end
  end

  private

  def fetch
    result = []
    while(limit == 0 || page <= limit)
      @page = 1 if page == 0
      url = URL + page.to_s
      puts "Fetching page #{page}..."
      result += JSON.parse(open(url).read)['results']
      puts "Found result #{result.count} recipes"
      @page += 1
    end
    result
  end
end

