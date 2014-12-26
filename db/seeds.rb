# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#load poke_zukan
=begin
open('db/poke_zukan.json') do |f|
  Pokemon.transaction do
    while line = f.gets
      pokemon = Pokemon.new.from_json(line)
      pokemon.save
    end
  end
end
=end

=begin
def insert_item
  open('db/poke_item.json') do |f|
    Item.transaction do
      while line = f.gets
        item = Item.new.from_json(line)
        item.save
      end
    end
  end
end
=end

=begin
#アイテム追加
open('db/poke_item.json') do |f|
  Item.transaction do
    while line = f.gets
      item = Item.new.from_json(line)
      item.save
    end
  end
end
=end

=begin
def insert_move
  open('db/poke_move.json') do |f|
    Move.transaction do
      while line = f.gets
        move = Move.new.from_json(line)
        move.save
      end
    end
  end
end
=end

#技追加
=begin
open('db/poke_move.json') do |f|
  Move.transaction do
    while line = f.gets
      move = Move.new.from_json(line)
      move.save
    end
  end
end
=end

=begin
move = Move.new(
  :move_id => 30,
  :name => "グロウパンチ"
  )
move.save
=end

Dir.glob(File.join(Rails.root,'db','seed','*.rb')) do |file|
  load(file)
end

if __FILE__ == $0
#  insert_item
#  insert_move
end