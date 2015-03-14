class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :name, :recipe_url, :ingredients

end
