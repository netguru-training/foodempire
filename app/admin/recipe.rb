ActiveAdmin.register Recipe do
  index do
    column :name
    column :total_calorie
    column :recipe_url
    column :picture_url
    column :created_at
    actions
  end

  remove_filter :ingredients_recipes
end
