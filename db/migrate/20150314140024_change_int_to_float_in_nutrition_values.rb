class ChangeIntToFloatInNutritionValues < ActiveRecord::Migration
  def change
    change_column :nutrition_values, :calories, :float
    change_column :nutrition_values, :carbs, :float
    change_column :nutrition_values, :sodium, :float
    change_column :nutrition_values, :fiber, :float
    change_column :nutrition_values, :protein, :float
  end
end
