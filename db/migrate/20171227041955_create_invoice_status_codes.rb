class CreateInvoiceStatusCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :invoice_status_codes do |t|
      t.text :description

      t.timestamps
    end
  end
end
