class AddDefaultValueForIngredientsIds < ActiveRecord::Migration
  def change
    change_column :users, :ingredients_ids, :integer, array: true, default: []
  end
end
