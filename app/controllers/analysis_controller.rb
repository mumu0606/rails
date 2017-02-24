#coding:utf-8
class AnalysisController < ApplicationController
  autocomplete :pokemon, :name
  layout "mylayout"

  PARTY_SIZE = 6
  NO_MOVE_ID = 606 #技なしのid
  NO_ITEM_ID = 117   #持ち物なしのid

  def index
    @result_hash = {}
    if params[:party_member]
      input_party_ids = params[:party_member]
      get_kp_hash(translate_name_to_id(input_party_ids))
    end
  end


private
  #kp_hashを計算し，それを用いて各ポケモンのアイテム・技予測を行う
  #ke_hash: 各pokemon_dataのidをキーにしてそのパーティに対してどれだけポケモンがかぶっているかの値をvalueとする
  #member_id_arr: パーティーメンバーのidを格納した配列
  def get_kp_hash(member_id_arr)
    member_id_arr.each_with_index do |member_id,i|
      #一緒に手持ちに入れられているポケモンのid配列を取得
      partner_id_arr = except_at(member_id_arr, i)
      pokemon_datum = PokemonInfo.where(pokemon_id:member_id)

      #ポケモンデータに格納された各行の情報に対して一緒に手持ちに入れられているポケモンがどれだけかぶっているかを計算する
      kp_hash = {}
      pokemon_datum.each do |row|
        kp = 0
        kp += 1 if partner_id_arr.include?(row["partner1"])
        kp += 1 if partner_id_arr.include?(row["partner2"])
        kp += 1 if partner_id_arr.include?(row["partner3"])
        kp += 1 if partner_id_arr.include?(row["partner4"])
        kp += 1 if partner_id_arr.include?(row["partner5"])
        kp_hash[row.id] = kp
      end

      member_name = Pokemon.find(member_id)[:name]
      @result_hash[member_name] = compute_item_moves_on_kp(kp_hash)
    end
  end

  #配列から特定のindex番目の要素を除いた配列を返す
  def except_at(arr, index)
    unless index == 0
      excepted_arr = arr.slice(0..index-1) + arr.slice(index+1..-1)
    else
      excepted_arr = arr.slice(1..-1)
    end
    return excepted_arr
  end

  #技とアイテムの予測値ハッシュを求める
  #{id: expectancy}
  def get_expectancy_hash(kp_hash)
    item_expectancy_hash = {}
    move_expectancy_hash = {}
    kp_hash.each do |pokemon_info_id, kp|
      item_id = PokemonInfo.find(pokemon_info_id)[:item]
      move_id_arr = []
      move_id_arr.push(PokemonInfo.find(pokemon_info_id)[:move1])
      move_id_arr.push(PokemonInfo.find(pokemon_info_id)[:move2])
      move_id_arr.push(PokemonInfo.find(pokemon_info_id)[:move3])
      move_id_arr.push(PokemonInfo.find(pokemon_info_id)[:move4])

      item_expectancy_hash[item_id] ||= kp
      item_expectancy_hash[item_id] += kp
      move_id_arr.each do |move_id|
        move_expectancy_hash[move_id] ||= kp
        move_expectancy_hash[move_id] += kp
      end
    end
    return item_expectancy_hash, move_expectancy_hash
  end

  #アイテム及び技の予測値を計算する
  #アイテム::KP合計
  #技::KP合計 + 最有力のアイテムと技の共起度
  def compute_item_moves_on_kp(kp_hash)
    result_hash = {
      :item => nil,
      :move1 => nil,
      :move2 => nil,
      :move3 => nil,
      :move4 => nil
    }
    item_expectancy_hash, move_expectancy_hash = get_expectancy_hash(kp_hash)

    #item_expectancy_hashをkpが高い順にソートして最初の要素を予測アイテムとする
    sorted_item_hash = item_expectancy_hash.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }
    #sortしたハッシュはarrに型変換される
    item_expectancy_id = sorted_item_hash.first.present? ? sorted_item_hash[0].first : NO_ITEM_ID

    #持ち物と技の共起度を用いて技の予測値を更新する
    #アイテムに対してそのアイテムが使われているときに採用されている技の予測値を高くする
    move_expectancy_hash.each_key do |move_expectancy_id|
      move_item = MoveItem.where("move_id = ? and item_id = ?", move_expectancy_id, item_expectancy_id)
      cooccur = move_item.present? ? move_item.first[:cooccur] : 0
      move_expectancy_hash[move_expectancy_id] += cooccur #この倍率は要調整
    end

    #技候補がない場合は"-"と表示するのでNO_MOVE_IDを代入
    sorted_move_hash = move_expectancy_hash.sort {|(k1, v1), (k2, v2)| v2 <=> v1 }
    move1_expectancy_id = sorted_move_hash[0].present? ? sorted_move_hash[0].first : NO_MOVE_ID
    move2_expectancy_id = sorted_move_hash[1].present? ? sorted_move_hash[1].first : NO_MOVE_ID
    move3_expectancy_id = sorted_move_hash[2].present? ? sorted_move_hash[2].first : NO_MOVE_ID
    move4_expectancy_id = sorted_move_hash[3].present? ? sorted_move_hash[3].first : NO_MOVE_ID

    result_hash[:item]  = Item.find(item_expectancy_id)[:name]
    result_hash[:move1] = Move.find(move1_expectancy_id)[:name]
    result_hash[:move2] = Move.find(move2_expectancy_id)[:name]
    result_hash[:move3] = Move.find(move3_expectancy_id)[:name]
    result_hash[:move4] = Move.find(move4_expectancy_id)[:name]

    return result_hash
  end
end