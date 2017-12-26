class OrderItemStatusCode < ApplicationRecord
  validates_presence_of :description
  has_many :order_items,  dependent: :destroy
end
