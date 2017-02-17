URL_POKEMON = 'db/seed/pokedex/pokedex.json'

def insert_seed
  open(URL_POKEMON) do |f|
    Pokemon.transaction do
      while l = f.gets
        pokemon = Pokemon.new.from_json(l)
        pokemon.save
      end
    end
  end
end

#データを挿入するときはコメントを外す
#insert_seed
