FactoryGirl.define do
  factory :category do
    name Faker::Name.title

    after(:create) do |c|
      c.products << FactoryGirl.create(:product, published: true)
      c.products << FactoryGirl.create(:product, published: true, asin: "B019RIOJNY")
    end
  end
end
