class DropTableMoveItem < ActiveRecord::Migration
  def change
    drop_table :move_items
  end
end
