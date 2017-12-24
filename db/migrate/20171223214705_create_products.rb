class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :color
      t.integer :size
      t.text :description

      t.timestamps
    end
  end
end
