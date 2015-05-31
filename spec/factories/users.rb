FactoryGirl.define do
  factory :user do
    confirmed_at Time.now
    name "Test User"
    sequence(:email, 1) { |n| "test#{n}@example.com" }
    password "please123"
  end
end
