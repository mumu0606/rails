class CreateMoves < ActiveRecord::Migration
  def change
    create_table :moves do |t|
      t.string :move_id
      t.string :name

      t.timestamps null: false
    end
  end
end
