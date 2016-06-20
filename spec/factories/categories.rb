FactoryGirl.define do
  factory :category do
    name Faker::Name.title
  end

  factory :category_with_product do
    title Faker::Name.title
    association :product, factory: :published_product_with_asin_1
    association :product, factory: :unpublished_product_with_asin_3
  end
end
