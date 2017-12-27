class Invoice < ApplicationRecord
  belongs_to :order
  belongs_to :invoice_status_code

  validates_presence_of :date
end
