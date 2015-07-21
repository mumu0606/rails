URL_POKEMON = 'db/seed/poke_zukan.json'

def insert_pokemon
  open(URL_POKEMON) do |f|
    Pokemon.transaction do
      while l = f.gets
        pokemon = Pokemon.new.from_json(l)
        pokemon.save
      end
    end
  end
end

#insert_pokemon
