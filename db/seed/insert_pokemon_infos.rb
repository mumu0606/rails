JSON_FILE_PATH = 'db/seed/party_infos.json'
YAML_FILE_PATH = 'db/seed/party_infos.yaml'
require 'json'
require 'yaml'

PARTY_SIZE = 6

#パーティーメンバー（名前）からパーティーメンバー（id）情報に変換
def translate_name_to_id(party_member_names)
  party_member_ids = []
  party_member_names.each do |poke_name|
    poke = Pokemon.where(name:poke_name).first
    if poke == nil
      p "NameError:#{poke_name}" 
      break
    else
      party_member_ids.push(poke["poke_id"])
    end
  end
  return party_member_ids
end

#パーティーの情報からパーティ内の各ポケモンのpokemon_infoを作成
def get_pokemon_info_from_party_info(party_member_ids,party_member_infos)
  party_member_ids.each_with_index do |poke_id,i|
    poke_name = Pokemon.where(poke_id:poke_id).first["name"]

    #アイテムid
    item_name = party_member_infos[poke_name]["item"]
    item_id = Item.where(name:item_name).first["item_id"]

    #一緒に手持ちに入っているポケモンのid配列を取得
    partner_ids = party_member_ids.slice(0..i) + party_member_ids.slice(i..PARTY_SIZE)

    #覚えている技
    move1_name = party_member_infos[poke_name]["move1"]
    move2_name = party_member_infos[poke_name]["move2"]
    move3_name = party_member_infos[poke_name]["move3"]
    move4_name = party_member_infos[poke_name]["move4"]

    pokemon_info = PokemonInfo.create(
      :pokemon_id => poke_id,
      :item => item_id,
      :partner1 => partner_ids[0],
      :partner2 => partner_ids[1],
      :partner3 => partner_ids[2],
      :partner4 => partner_ids[3],
      :partner5 => partner_ids[4],
      :move1 => Move.where(name:move1_name).first["move_id"],
      :move2 => Move.where(name:move2_name).first["move_id"],
      :move3 => Move.where(name:move3_name).first["move_id"],
      :move4 => Move.where(name:move4_name).first["move_id"]
    )

    update_cooccur(pokemon_info)
  end
end

#アイテムと技の共起度を更新
def update_cooccur(pokemon_info)
    item_id = pokemon_info["item"]
    move_ids = []
    move_ids.push(pokemon_info["move1"])
    move_ids.push(pokemon_info["move2"])
    move_ids.push(pokemon_info["move3"])
    move_ids.push(pokemon_info["move4"])

    item = Item.find(item_id)
    move_ids.each do |move_id|
      move_item = item.move_items.find_or_initialize_by(move_id:move_id)
      if move_item.new_record?
        move_item.update_attributes(:cooccur => 1)
      else
        move_item.update_attributes(:cooccur => move_item['cooccur'] + 1)
      end
    end
end

=begin
def get_pokemon_infos
  partys = open(JSON_FILE_PATH) do |io|
    JSON.load(io)
  end
  partys.each do |party|
    party_member_names = party["party_member_names"]
    party_member_infos = party["party_member_infos"]
    p party_member_names

    #id形式のパーティ情報
    party_member_ids = translate_name_to_id(party_member_names)
    get_pokemon_info_from_party_info(party_member_ids,party_member_infos)
  end
end
=end

def get_pokemon_infos
  File.open(YAML_FILE_PATH) do |io|
    YAML.load_documents(io) do |party|
      party_member_names = party.keys
      party_member_infos = party

      party_member_ids = translate_name_to_id(party_member_names)
      get_pokemon_info_from_party_info(party_member_ids,party_member_infos)
    end
  end
end


get_pokemon_infos