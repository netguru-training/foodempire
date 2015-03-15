ActiveAdmin.register Ingredient do
  index do
    column :name
    column :created_at
    actions
  end

  remove_filter :ingredients_recipes
end
