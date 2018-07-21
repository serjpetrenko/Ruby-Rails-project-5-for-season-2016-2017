FactoryBot.define do
  factory :dish do
    name { Faker::Internet.name }
    description { Faker::Lorem.sentence }
    price 100
    weight 100
  end
end
