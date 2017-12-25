FactoryGirl.define do
  factory :order do
    date { Faker::Date }
    description { Faker::Lorem.paragraphs }
    order_status_code_id nil
  end
end