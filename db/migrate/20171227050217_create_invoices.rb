class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.date :date
      t.text :description
      t.references :order, foreign_key: true
      t.references :invoice_status_code, foreign_key: true

      t.timestamps
    end
  end
end
