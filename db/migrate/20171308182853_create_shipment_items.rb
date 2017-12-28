class CreateShipmentItems < ActiveRecord::Migration[5.1]
  def change
    create_table :shipment_items do |t|
      t.references :shipment, foreign_key: true
      t.references :order_item, foreign_key: true

      t.timestamps
    end
  end
end
