class RecipeFinder
  def initialize(ingredients)
    @ingredients = ingredients
  end

  def search
    @recipes = Recipe.joins(:ingredients)
  end

  private
  attr_reader :ingredients
end