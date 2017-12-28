class PaymentMethod < ApplicationRecord
  validates_presence_of :description
end
