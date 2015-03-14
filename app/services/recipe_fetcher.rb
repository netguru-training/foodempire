require 'open-uri'
require 'json'

class RecipeFetcher
  URL = 'http://www.recipepuppy.com/api/?p='

  attr_accessor :page

  def initialize(page = 0)
    @page = page
  end

  def self.call(page = 0)
    new(page).call
  end

  def call
    results = fetch
    ingriedents_for_recipe = []
    results.each do |result|
      ingredients = result['ingredients'].split(', ')
      ingredients.each do |ingredient|
        ingriedents_for_recipe << Ingredient.find_or_create_by(name: ingredient)
      end
      Recipe.create(name: result['title'], recipe_url: result['href'], picture_url: result['thumbnail'], ingredients: ingriedents_for_recipe)
    end
  end

  private

  def fetch
    result = []
    while(page < 3)
      self.page += 1
      url = URL + page.to_s
      result += JSON.parse(open(url).read)['results']
    end
    result
  end
end

