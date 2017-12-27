FactoryGirl.define do
  factory :shipment do
    tracking_number "1234567890123456"
    date { Faker::Date.between(2.days.ago, Date.today) }
    description { Faker::Lorem.paragraphs }
    order_id nil
    invoice_id nil
  end
end