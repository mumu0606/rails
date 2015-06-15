class AddPokeIdToData < ActiveRecord::Migration
  def change
    add_column :data,:poke_id,:integer
  end
end
