class Ingredient < ActiveRecord::Base
  has_and_belongs_to_many :ingredients

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: false }
end
