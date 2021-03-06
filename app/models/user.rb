class User < ActiveRecord::Base
  has_many :favorites, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates_format_of :blacklisted_ingredients, with: /\A(\w+,\s)*\w*\z/

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
     end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def ingredients
    Ingredient.where(id: ingredients_ids)
  end


  def add_to_favorite(recipe_id)
    recipe = favorites.find_by(recipe_id: recipe_id)
    if !(recipe)
      recipe = favorites.build(recipe_id: recipe_id)
    end
    recipe
  end

  def remove_favorite(recipe)
      recipe.destroy
  end

  def blacklisted
    return Array.new if blacklisted_ingredients.blank?
    Ingredient.where(name: blacklisted_ingredients.split(', '))
  end

end
