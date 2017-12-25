class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.date :date
      t.text :description
      t.references :order_status_code, foreign_key: true

      t.timestamps
    end
  end
end
