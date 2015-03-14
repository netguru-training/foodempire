class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.references :recipe, index: true
      t.belongs_to :user, index: true

      t.timestamps
    end
  end
end
