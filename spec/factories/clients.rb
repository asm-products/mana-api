FactoryGirl.define do
  factory :client do
    name "TestName"
	address "123 Test Dr. SomeCity TX, 12345 United States"
	phone "1234567890"
	sequence(:slug, 1) { |n| "slug#{n}" }
	website "http://www.test.com"
  end
end
