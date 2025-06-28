FactoryBot.define do
  factory :post do
    title { "MyString" }
    content { "MyText" }
    user { nil }
    author { nil }
  end
end
