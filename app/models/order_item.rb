class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order
  belongs_to :order_item_status_code
  validates_presence_of :quantity, :price
  has_many :shipment_items
  has_many :shipments, :through => :shipment_items

end
