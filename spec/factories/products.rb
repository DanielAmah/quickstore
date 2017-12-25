FactoryGirl.define do
    factory :product do
      name { Faker::Lorem.word }
      price { Faker::Number.decimal(2)}
      color { Faker::Lorem.word }
      size { Faker::Number.number(4) }
      description { Faker::Lorem.paragraphs }
      category_id nil
    end
  end