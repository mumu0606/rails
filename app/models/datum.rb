require 'matrix'

class Data < ActiveRecord::Base
  belongs_to :pokemon, :primary_key => "poke_id",:foreign_key => "poke_id"
  serialize :party_member
  serialize :item
  serialize :move

  PARTY_SIZE = 6
  POKEMON_ZUKAN_SIZE = 719

  def self.party_member_vector(self_id,party_member_id)
    party_member = []
    party_member_vector = []
    for i in 1..POKEMON_ZUKAN_SIZE do
      #自分を除くパーティーメンバーのidの要素は１、それ以外は０のベクトルを作成する
      if party_member_id.include?(i) && i != self_id
        party_member.push(1)
      else
        party_member.push(0)
      end
    end

    #ベクトルに変換
    party_member_vector = Vector.elements(party_member,false)
    return party_member_vector
  end

  def self.translate_vector_to_name(party_vector)
    party_array = party_vector.to_a
    party_name = []
    party_array.each_with_index do |id,i|
      if id == 1
        party_name.push(Pokemon.where(poke_id:i + 1).first["name"])
      end
    end
    return party_name
  end


  #あるポケモンにたいしてそのidとパーティメンバーのidを入力としてそのポケモンの{:name => "技名かアイテム名",:percentage => "予想確立係数"}ハッシュを{:item:アイテム情報ハッシュ,:move:技情報ハッシュ}の形で出力する
  def self.predict_itemove(self_id,party_member_id)
    party_member_vector = Data.party_member_vector(self_id,party_member_id)
    #データの中で対象とするポケモンidのものを全て取得
    datum = Data.where(pokemon_id:self_id)
    #持ち物，技の予測値を格納するハッシュ
    predicted_item_hash = {}
    predicted_move_hash = {}
    predicted_hash = {}
    datum.each do |data|
      #パーティメンバーの情報を持ちいて相関係数を計算
      correlation_coefficient = party_member_vector.inner_product(data["party_member"])
      predicted_item_hash = Data.hash_calcuration(predicted_item_hash,data["item"],correlation_coefficient)
      predicted_move_hash = Data.hash_calcuration(predicted_move_hash,data["move"],correlation_coefficient)
    end
    predicted_moves = self.calculate_percentage(predicted_move_hash)[0..5]
    predicted_item = self.calculate_percentage(predicted_item_hash)[0]
    #raise predicted_item.inspect
    #アイテム情報なしの場合分岐
    protected_moves = Data.calc_itemove(predicted_item,predicted_moves)
    #raise predicted_moves.inspect
    predicted_hash["item"] = predicted_item
    predicted_hash["move"] = predicted_moves.sort_by{|data| data['percentage']}.reverse
    return predicted_hash
  end

  #ハッシュ同士の計算を行う
  def self.hash_calcuration(hash1,hash2,correlation_coefficient)
    hash2.keys.each do |key|
      hash1[key] = 0 if hash1[key] == nil
      hash1[key] = hash1[key] + correlation_coefficient * hash2[key]
    end
    return hash1
  end

  #技予測値ハッシュを与え推定度の高い技候補を選択
  def self.decide_moves(moves_hash)
    sorted_hash = Hash[*moves_hash.sort_by{|key,val| -val}.flatten]
    predicted_moves = sorted_hash.keys[0..3]
    return predicted_moves
  end

  #アイテム予測値ハッシュを与え推薦度高い道具候補を選択
  def self.decide_item(items_hash)
    sorted_hash = Hash[*items_hash.sort_by{|key,val| -val}.flatten]
    predicted_item = sorted_hash.keys[0]
    return predicted_item
  end

  #予測アイテムハッシュと予測技ハッシュを与えてアイテムと技の共起度の情報からあってはならない技を削除
  def self.calc_itemove(item_hash,move_hash)
    #アイテム情報がない場合は何もしない
    temp = []
    unless item_hash.nil?
      item = Item.where(name:item_hash['name']).first
      move_hash.each do |move|
        move_name = move['name']
        move_id = Move.where(name:move_name).first['move_id']
        #アイテムとの共起度が0の技の優先度を下げる
        if item.move_items.where(move_id:move_id).length == 0
          #raise move_hash.inspect
          move['percentage'] = move['percentage'] - 10
        end
      end
      return move_hash
    end
  end


  #ハッシュ値から各アイテム・技が選ばれている確立を計算する．返り値は{:"name" => "技名かアイテム名",:"percentage" => "予想確立係数"}のハッシュが予想確立係数の高い順に格納された配列
  def self.calculate_percentage(hash)
    occurence = 0
    predicted_array = []

    #value（各項目の登場回数）の降順でハッシュをソート
    sorted_hash = Hash[*hash.sort_by{|key,val| -val}.flatten]

    sorted_hash.values.each do |val|
      occurence += val
      break if val == 0
    end

    sorted_hash.each do |key,val|
      #確立が０の技もしくはアイテムが出たところで中断
      break if val == 0
      predicted_array.push({"name" => key,"percentage" => val / occurence.to_f * 100})
    end

    return predicted_array
  end

  #アイテムオブジェクトハッシュからアイテムidを抽出する{"name":道具名x,"bool":1} => 道具名x
  def self.get_itemid_from_data(data)
    item_id = ""
    data["item"].each do |key,val|
      if val != 0
        item_id = Item.where(name:key).first["item_id"]
        break
      end
    end
    return item_id
  end

  #技オブジェクトハッシュから技idを抽出する{{"item":技名x,"bool":1},{"item":技名y,"bool":1}},{"item":技名z,"bool":0} => [技名x,技名y]
  def self.get_moveid_from_data(data)
    move_ids = []
    data["move"].each do |key,val|
      move_ids.push(Move.where(name:key).first["move_id"]) if val != 0
    end
    return move_ids
  end


  #パーティの情報つっこんで，メンバー全員のdataを作成
  def self.make_data(detailed_party,party_id)
    party_id.each_with_index do |poke_id,i|
      #自身以外のメンツのidを格納した配列を作成
      member_ids = party_id.slice(0..i) + party_id.slice(i..PARTY_SIZE)

      #技名の配列
      moves = detailed_party[Pokemon.where(poke_id:poke_id).first['name']]['move']
      move_ids = []
      moves.each do |move|
        move_ids.push(Move.where(move_id:move_id).first['move_id'])
      end

      data = Data.new(
        :p1 => member_ids[0],
        :p2 => member_ids[1],
        :p3 => member_ids[2],
        :p4 => member_ids[3],
        :p5 => member_ids[4],
        :m1 => move_ids[0],
        :m2 => move_ids[1],
        :m3 => move_ids[2],
        :m4 => move_ids[3]
        )
      data.save

      #アイテムと技の関係性の更新
      #このデータactiverecordで管理するのよろしくない
      MoveItems.calculate_count_with(data)
    end
  end
end
