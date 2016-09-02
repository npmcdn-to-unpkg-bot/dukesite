FactoryGirl.define do
  factory :admin do
    email    { Faker::Internet.safe_email }
    password { Faker::Internet.password }
  end
end
