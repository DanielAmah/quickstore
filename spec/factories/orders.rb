FactoryGirl.define do
  factory :order do
    date { Faker::Date.between(2.days.ago, Date.today) }
    description { Faker::Lorem.paragraphs }
    order_status_code_id nil
  end
end