FactoryGirl.define do
  factory :site_config do
    value { Faker::Lorem.sentence }
  end
end
