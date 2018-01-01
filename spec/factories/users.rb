FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    phone_number "08123293233"
    address { Faker::Lorem.paragraphs }
    city { Faker::Lorem.word }
    state { Faker::Lorem.word }
    country { Faker::Lorem.word }
    role_id nil
  end
end