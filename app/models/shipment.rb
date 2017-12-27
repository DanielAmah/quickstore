class Shipment < ApplicationRecord
  belongs_to :order
  belongs_to :invoice
  validates_presence_of :tracking_number, :date
end
