URL_MOVE = 'db/seed/poke_move.json'

def insert_move
  open(URL_MOVE) do |f|
    Move.transaction do
      while line = f.gets
        puts line
        move = Move.new.from_json(line)
        move.save
      end
    end
  end
end

insert_move

