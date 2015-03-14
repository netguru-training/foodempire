class CreateIngredientsAndRecipes < ActiveRecord::Migration
 def change
    create_table :ingredients do |t|
      t.string :name, null: false
      t.timestamps null: false
    end

    create_table :recipes do |t|
      t.string :name, null: false
      t.string :recipe_url, null: false
      t.string :picture_url
      t.timestamps null: false
    end

    create_table :ingredients_recipes, id: false do |t|
      t.belongs_to :ingredient, index: true, null: false
      t.belongs_to :recipe, index: true, null: false
    end
  end
end
