class Invoice < ApplicationRecord
  belongs_to :order
  belongs_to :invoice_status_code
  has_many :shipments,  dependent: :destroy
  validates_presence_of :date
end
