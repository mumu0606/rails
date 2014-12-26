require 'open-uri'
require 'nokogiri'

#ポケモンの図鑑番号と名前をスクレイピングする
url = 'http://pente.koro-pokemon.com/zukan/'

#技一覧を含むurl
$URL_MOVE = 'http://wiki.gamerp.jp/pokemon/data/283.html'

=begin
doc = Nokogiri::HTML(open(url))
lists = doc.xpath('//li')

File.open("poke_zukan.json","w") do |f|
  lists.each do |l|
    id,name = l.inner_text.split(" ")
    json = "{\"poke_id\":%d,\"name\":\"%s\"}\n" % [id.to_i,name]
    f.write(json)
  end
end
=end

def get_moves
  doc = Nokogiri::HTML(open($URL_MOVE))
  moves = doc.xpath('//a')
  #puts moves

  File.open("poke_move.json","w") do |f|
    moves.each_with_index do |move,i|
      move = move.inner_text
      json = "{\"move_id\":%d,\"name\":\"%s\"}\n" % [i,move]
      f.write(json)
    end
  end
end

def get_megastone
  doc = Nokogiri::HTML(open("http://blog.game-de.com/pm-oras/oras-megastone/"))
  lists = doc.xpath('//td')

  File.open("mega_stone.json","w") do |f|
    lists.each_with_index do |list,i|
      list = list.inner_text
      json = "{\"item_id\":%d,\"name\":\"%s\"}\n" % [i,list]
      f.write(json)
    end
  end
end

def format_mega_stone
  File.open("mega_stone_f.json","w") do |f_f|
    File.open("mega_stone.json","r") do |f|
      count = 69
      #reg = Regexp.compile("{\"item_id\":(\d+),\"name\":\"(.+)\"}\n")
      while line = f.gets
        #puts reg
        puts line
        if /{\"item_id\":(\d+),\"name\":\"(.+)\"}\n/ =~ line
          puts "test"
          m = line.match(/{\"item_id\":(\d+),\"name\":\"(.+)\"}\n/)
          stone_name = m[2]
          json = "{\"item_id\":%d,\"name\":\"%s\"}\n" % [count,stone_name]
          f_f.write(json)
        end
        count += 1
      end
    end
  end
end


if __FILE__ == $0
  format_mega_stone
end


