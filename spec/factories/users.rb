FactoryBot.define do
  factory :user do
    name { 'tester' }
    sequence(:email) { |n| "email#{n}@email.com" }
    password { 'password' }
  end
end
