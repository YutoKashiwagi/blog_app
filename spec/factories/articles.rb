FactoryBot.define do
  factory :article do
    association :user
    title { "MyString" }
    content { "MyText" }
    article_image { "MyString" }
  end
end
