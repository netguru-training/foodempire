FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password 'password'
    blacklisted_ingredients 'nuts milk'
  end
end
