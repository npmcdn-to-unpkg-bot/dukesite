FactoryGirl.define do
  factory :social_network_account do
    platform_name { Faker::Name.title }
    platform_url  { Faker::Internet.url('example.com') }
    
    trait :visible do
      visible    true
    end
    trait :invisible do
      visible    false
    end
  end
end
