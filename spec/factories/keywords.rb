FactoryGirl.define do
  factory :keyword do
    value { Faker::Hipster.sentence }   
  end
end
