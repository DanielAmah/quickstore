class Order < ApplicationRecord
  belongs_to :order_status_code
  has_many :order_items,  dependent: :destroy
  validates_presence_of :date
end
