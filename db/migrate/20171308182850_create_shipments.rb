class CreateShipments < ActiveRecord::Migration[5.1]
  def change
    create_table :shipments do |t|
      t.string :tracking_number
      t.date :date
      t.text :description
      t.references :order, foreign_key: true
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
