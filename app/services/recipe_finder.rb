class RecipeFinder
  def initialize(ingredients, user)
    @ingredients = ingredients.map(&:to_i)
    @user = user
  end

  def search
    @recipes = Recipe.without_blacklist(@user).includes(:ingredients)
    @recipes = @recipes.select { |recipe| (@ingredients - recipe.ingredients.pluck(:id)).empty? }
  end

  private
  attr_reader :ingredients
end