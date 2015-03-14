FactoryGirl.define do
  factory :ingredient do
    sequence(:name) { |n| "potato #{n}" }
  end
end
