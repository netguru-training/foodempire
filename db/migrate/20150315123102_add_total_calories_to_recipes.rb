class AddTotalCaloriesToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :total_calories, :float
  end
end
