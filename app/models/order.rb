class Order < ApplicationRecord
  belongs_to :order_status_code
  has_many :order_items,  dependent: :destroy
  has_many :invoices,  dependent: :destroy
  validates_presence_of :date
end
