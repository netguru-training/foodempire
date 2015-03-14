class CreateNutritionValues < ActiveRecord::Migration
  def change
    create_table :nutrition_values do |t|
      t.string :serving
      t.integer :calories
      t.integer :carbs
      t.integer :sodium
      t.integer :fiber
      t.integer :protein

      t.timestamps null: false
      t.belongs_to :ingredient, null: false
    end
  end
end
