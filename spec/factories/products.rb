FactoryGirl.define do
  factory :product do
    title     Faker::Name.title
    url       Faker::Internet.url('example.com')
    image_url Faker::Avatar.image
    asin      "B01BY3PEUM"
  end
end
