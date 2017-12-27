class CreatePayments < ActiveRecord::Migration[5.1]
  def change
    create_table :payments do |t|
      t.date :date
      t.float :amount
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
