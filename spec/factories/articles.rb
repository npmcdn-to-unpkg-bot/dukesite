FactoryGirl.define do
  factory :article do
    title { Faker::Name.title }
    content { Faker::Lorem.paragraph }

    trait :published do
      published    true
    end
    trait :unpublished do
      published    false
    end
  end
end
