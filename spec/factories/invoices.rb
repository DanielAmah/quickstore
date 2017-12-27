FactoryGirl.define do
  factory :invoice do
    date { Faker::Date.between(2.days.ago, Date.today) }
    description { Faker::Lorem.paragraphs }
    order_id nil
    invoice_status_code_id nil
  end
end