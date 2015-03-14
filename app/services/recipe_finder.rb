class RecipeFinder
  def initialize(ingredients)
    @ingredients = ingredients.map(&:to_i)
  end

  def search
    @recipes = Recipe.includes(:ingredients)
    @recipes = @recipes.select { |recipe| (@ingredients - recipe.ingredients.pluck(:id)).empty? }
  end

  private
  attr_reader :ingredients
end