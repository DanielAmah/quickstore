class InvoiceStatusCode < ApplicationRecord
  validates_presence_of :description
  has_many :invoices,  dependent: :destroy

  def self.get_invoice_status_code
    all
  end

  def self.create_invoice_status_code(invoice_status_code_params)
    create!(invoice_status_code_params)
  end

  def self.find_invoice_status_code(params)
    find(params[:id])
  end
end
