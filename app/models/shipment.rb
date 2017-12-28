class Shipment < ApplicationRecord
  belongs_to :order
  belongs_to :invoice
  validates_presence_of :tracking_number, :date
  has_many :shipment_items
  has_many :order_items, :through => :shipment_items
end
