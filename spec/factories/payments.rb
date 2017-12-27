FactoryGirl.define do
  factory :payment do
    date { Faker::Date.between(2.days.ago, Date.today) }
    amount { Faker::Number.decimal(2) }
    invoice_id nil

  end
end