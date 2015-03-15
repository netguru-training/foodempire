require 'rails_helper'
require 'spec_helper'
describe CalorificRecipeCalculate do
  let!(:water) { create(:ingredient, name: 'water',id: 1) }
  let!(:apple) { create(:ingredient, name: 'apple',id: 2) }
  let!(:arctic_water) { create(:nutrition_value, serving: '1 cup',id: 1, ingredient_id:1, calories: 10.0) }
  let!(:polish_apple) { create(:nutrition_value, serving: 'Apple - Big one',id: 2, ingredient_id:2, calories: 25.0) }
  let!(:apple_juice) { create(:recipe, name: 'apple juice', ingredients: [water, apple])}

    it 'calculate total calories for recipe' do
      CalorificRecipeCalculate.call
      expect(Recipe.first.total_calories).to eq 35.0
    end
  end

