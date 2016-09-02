FactoryGirl.define do
  factory :product do
    title     { Faker::Name.title }
    trait :valid_attributes do
      url             { Faker::Internet.url('example.com') }
      image_url       { Faker::Avatar.image }
      image_url_small { Faker::Avatar.image }
    end
    
    trait :published do
      published    true
    end
    trait :unpublished do
      published    false
    end

    trait :asin_1 do
      asin         "B01BY3PEUM"
    end

    trait :asin_2 do
      asin         "B019RIOJNY"
    end

    trait :asin_3 do
      asin         "B0181P6WNY"
    end

    trait :asin_4 do
      asin         "B018JOC402"
    end

    factory :published_product_with_asin_1, traits: [:valid_attributes, :published, :asin_1]
    factory :published_product_with_asin_2, traits: [:valid_attributes, :published, :asin_2]
    factory :unpublished_product_with_asin_3, traits: [:valid_attributes, :unpublished, :asin_3]
    factory :unpublished_product_with_asin_4, traits: [:valid_attributes, :unpublished, :asin_4]
    factory :invalid_product

  end
end
