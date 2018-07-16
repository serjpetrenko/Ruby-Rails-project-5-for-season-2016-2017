FactoryBot.define do
  factory :user do
    first_name "name"
    last_name "last name"
    email "email@gmail.com"
    password_digest "Test1234!"
  end
end
