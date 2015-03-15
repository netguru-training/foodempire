class Recipe < ActiveRecord::Base

  has_many :ingredients_recipes
  has_many :ingredients, through: :ingredients_recipes
  has_many :favorites, dependent: :destroy
  validates :name, :recipe_url, :picture_url, presence: true
  validates :name, uniqueness: { case_sensitive: false }

  def self.without_blacklist(user)
    return Recipe.all if user.blank?
    Recipe.where.not(id: IngredientsRecipe
      .select(:recipe_id)
      .where(ingredient: user.blacklisted))
  end

end
