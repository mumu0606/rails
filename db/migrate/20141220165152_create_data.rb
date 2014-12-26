class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.integer :pokemon_id
      t.text :party_member
      t.text :item
      t.text :move

      t.timestamps null: false
    end
  end
end
