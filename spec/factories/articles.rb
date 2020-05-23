FactoryBot.define do
  factory :article do
    user { nil }
    title { "MyString" }
    content { "MyText" }
    article_image { "MyString" }
  end
end
