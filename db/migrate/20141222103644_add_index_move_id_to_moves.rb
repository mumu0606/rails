class AddIndexMoveIdToMoves < ActiveRecord::Migration
  def change
    add_index :moves,[:move_id], :unique => true
  end
end
