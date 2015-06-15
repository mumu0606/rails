class AddIndexToPokemon < ActiveRecord::Migration
  def change
    add_index :pokemons, :name
    add_index :pokemons, :poke_id
  end
end
