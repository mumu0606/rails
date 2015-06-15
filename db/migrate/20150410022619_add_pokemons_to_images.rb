class AddPokemonsToImages < ActiveRecord::Migration
  def change
    add_column :pokemons, :image, :text
  end
end
