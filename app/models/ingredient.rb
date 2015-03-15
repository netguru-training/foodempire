class Ingredient < ActiveRecord::Base
  has_many :favorites, dependent: :destroy
  #has_and_belongs_to_many :recipes
  has_many :ingredients_recipes
  has_many :recipes, through: :ingredients_recipes
  has_many :nutrition_values
  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
