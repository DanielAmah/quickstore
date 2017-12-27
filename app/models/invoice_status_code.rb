class InvoiceStatusCode < ApplicationRecord
  validates_presence_of :description
  has_many :invoices,  dependent: :destroy
end
