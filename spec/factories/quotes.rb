FactoryGirl.define do
  factory :quote do
    title Faker::Name.title

    trait :visible do
      visible    true
    end
    trait :invisible do
      visible    false
    end
  end
end
