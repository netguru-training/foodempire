class AddIngredientsIdsToUser < ActiveRecord::Migration
  def change
    add_column :users, :ingredients_ids, :integer, array: true
  end
end
