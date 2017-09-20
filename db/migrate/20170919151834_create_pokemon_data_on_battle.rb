class CreatePokemonDataOnBattle < ActiveRecord::Migration
    def change
        create_table(:pokemon_data_on_battles, :primary_key => 'sequence_id') do |t|
            t.integer    :secuence_id,   :null => false
            t.integer    :pokemon_id,    :null => false
            t.string     :party_members, :null => false
            t.string     :moves,         :null => false
            t.integer    :item_id,       :null => false
            t.timestamps                 :null => false

            t.index      :pokemon_id
        end
    end
end
