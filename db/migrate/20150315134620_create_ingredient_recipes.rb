class CreateIngredientRecipes < ActiveRecord::Migration
  def change
    create_table :ingredient_recipes do |t|
      t.references :recipe
      t.references :ingredient

      t.timestamps null: false
    end
  end
end
