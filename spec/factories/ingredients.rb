FactoryGirl.define do
  factory :ingredient do
    name "potato"
    association :recipes
  end
end
