class DropShipments< ActiveRecord::Migration[5.1]
  def up
    drop_table :shipments
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
