# test/factories/users.rb
FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "test-#{n}@example.com" }
    first_name { "Test" }
    last_name { "User" }
    password { "password" }
    password_confirmation { "password" }
    confirmed_at { Time.now.utc }
  end
end
