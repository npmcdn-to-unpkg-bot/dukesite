FactoryGirl.define do
  factory :article do
    title Faker::Name.title
    content Faker::Lorem.paragraph
  end
end
