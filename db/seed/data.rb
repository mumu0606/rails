JSON_FILE_PATH = 'db/seed/data.json'
require 'json'

#ポケモンの名前が入ったパーティをid形式に変換する
def translate_name_to_id(party_name)
  party_id = []
  party_name.each do |name|
    if Pokemon.where(name:name).first == nil
      puts "#{name} error___________" 
      break
    end
    poke_id = Pokemon.where(name:name).first["poke_id"]
    party_id.push(poke_id)
  end
  return party_id
end

def get_data
  partys = open(JSON_FILE_PATH) do |io|
    JSON.load(io)
  end
  partys.each do |party|
    simple_party = party["simple_party"]
    puts simple_party
    detailed_party = party["detailed_party"]
    #id形式のパーティ情報
    party_id = translate_name_to_id(simple_party)
    new_data = Datum.make_data(detailed_party,party_id)
    MoveItem.calculate_count_with(new_data)
  end
end

get_data

