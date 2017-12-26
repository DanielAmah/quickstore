class Order < ApplicationRecord
  belongs_to :order_status_code

  validates_presence_of :date
end
