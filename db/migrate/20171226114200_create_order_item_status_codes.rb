class CreateOrderItemStatusCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :order_item_status_codes do |t|
      t.text :description

      t.timestamps
    end
  end
end
