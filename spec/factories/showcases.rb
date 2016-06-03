FactoryGirl.define do
  factory :showcase do
    title Faker::Name.title

    after(:create) do |c|
      c.products << FactoryGirl.create(:product, published: true)
      c.products << FactoryGirl.create(:product, published: true, asin: "B019RIOJNY")
      c.products << FactoryGirl.create(:product, published: false, asin: "B0181P6WNY")
      c.products << FactoryGirl.create(:product, published: false, asin: "B019RIOJNY")
    end
  end
end
