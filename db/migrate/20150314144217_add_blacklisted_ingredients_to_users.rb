class AddBlacklistedIngredientsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :blacklisted_ingredients, :string
  end
end
