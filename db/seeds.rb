# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ingredients = Ingredient.create([{ name: 'onion' }, { name: 'garlic' }, { name: 'chicken' },
              { name: 'cheese' }, { name: 'oregano' }, { name: 'pepper' }])

recipe = Recipe.create({ name: 'Broccoli and Cheese',
  recipe_url: 'http://www.bigoven.com/45151-Broccoli-and-Cheese-Omelet-recipe.html',
  picture_url: 'http://img.recipepuppy.com/1.jpg'
})

recipe.ingredients = ingredients.first(3)
recipe.save
#####        A D M I N    A C C O U N T     ###########
user_a = AdminUser.new
user_a.email = "adminek@example.com"
user_a.password = 'adminek123'
user_a.password_confirmation = 'adminek123'
user_a.save!