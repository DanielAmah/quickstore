class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.integer :quantity
      t.float :price
      t.string :RMA_number
      t.date :RMA_date
      t.text :description
      t.references :product, foreign_key: true
      t.references :order, foreign_key: true
      t.references :order_item_status_code, foreign_key: true

      t.timestamps
    end
  end
end
