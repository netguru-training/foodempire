class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :quantity
      t.references :ingredient, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end
