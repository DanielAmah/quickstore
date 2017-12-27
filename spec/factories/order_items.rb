FactoryGirl.define do
  factory :order_item do
    quantity { Faker::Number.number(4) }
    price { Faker::Number.decimal(2)}
    RMA_number { Faker::Lorem.word }
    RMA_date { Faker::Date.between(2.days.ago, Date.today) }
    description { Faker::Lorem.paragraphs }
    product_id nil
    order_id nil
    order_item_status_code_id nil
  end
end