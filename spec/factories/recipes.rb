FactoryGirl.define do
  factory :recipe do
    sequence(:name) { |n| "Broccoli and Cheese #{n}" }
    recipe_url "http://www.bigoven.com/45151-Broccoli-and-Cheese-Omelet-recipe.html"
    picture_url "http://www.bigoven.com/45151-Broccoli-and-Cheese-Omelet-recipe.html"
    ingredients { [FactoryGirl.create(:ingredient)] }
  end
end
