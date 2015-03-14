FactoryGirl.define do
  factory :recipe do
    name "Broccoli and Cheese"
    recipe_url "http://www.bigoven.com/45151-Broccoli-and-Cheese-Omelet-recipe.html"
    picture_url "http://www.bigoven.com/45151-Broccoli-and-Cheese-Omelet-recipe.html"
    association :ingredients
  end
end
