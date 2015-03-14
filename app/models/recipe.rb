class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :ingredients

  validates :name, :recipe_url, :picture_url, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
