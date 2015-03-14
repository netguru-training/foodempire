# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ingredients = Ingredient.create([{ name: 'onion' }, { name: 'garlic' }, { name: 'chicken '}, { name: 'cheese' },
  { name: 'oregano' }, { name: 'pepper' }])

recipe = Recipe.create({ name: 'Broccoli and Cheese',
  recipe_url: 'http://www.bigoven.com/45151-Broccoli-and-Cheese-Omelet-recipe.html',
  picture_url: 'http://www.bigoven.com/45151-Broccoli-and-Cheese-Omelet-recipe.html'
})

recipe.ingredients = ingredients.first(3)
recipe.save
