class RemoveProduct < ActiveRecord::Migration
  def change
    drop_table :products
  end
end
