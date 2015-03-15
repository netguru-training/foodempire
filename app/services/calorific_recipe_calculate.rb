class CalorificRecipeCalculate
  attr_accessor :recipe

  def initialize(recipe = nil)
    @recipe = recipe
  end

  def self.call(recipe = nil)
    new(recipe).call
  end

  def call
    Recipe.all.each do |recipe|
      calories = 0.0
      unless recipe.total_calories.present?
        recipe.ingredients.each do |ingredient|
          calories += ingredient.nutrition_values.first.calories
        end
        recipe.total_calories = calories
        recipe.save
      end
    end
  end
end
