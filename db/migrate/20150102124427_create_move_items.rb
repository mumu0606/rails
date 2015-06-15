class CreateMoveItems < ActiveRecord::Migration
  def change
    create_table :move_items do |t|
      t.references :move, index: true
      t.references :item, index: true
      t.integer :cooccur

      t.timestamps null: false
    end
    add_foreign_key :move_items, :moves
    add_foreign_key :move_items, :items
  end
end
