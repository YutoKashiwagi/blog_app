FactoryBot.define do
  factory :comment do
    association :user
    association :article
    content { "MyText" }
  end
end
