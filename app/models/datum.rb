require 'matrix'

class Datum < ActiveRecord::Base
  belongs_to :pokemon, :foreign_key => "poke_id"
  serialize :party_member
  serialize :item
  serialize :move

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

  def self.predict_itemove(self_id,party_member_id)
    party_member_vector = Datum.party_member_vector(self_id,party_member_id)
    #データの中で対象とするポケモンidのものを全て取得
    datum = Datum.where(pokemon_id:self_id)
    #持ち物，技の予測値を格納するハッシュ
    predicted_item_hash = {}
    predicted_move_hash = {}
    datum.each do |data|
      #パーティメンバーの情報を持ちいて相関係数を計算
      correlation_coefficient = party_member_vector.inner_product(data["party_member"])
      #raise [party_member_vector,data["party_member"]].inspect
      raise correlation_coefficient.inspect
      predicted_item_hash.merge!(data["item"]){|key,v1,v2|
        v1 + correlation_coefficient * v2
      }
      predicted_move_hash.merge!(data["move"]){|key,v1,v2|
        v1 + correlationcoefficient * v2
      }
      raise predicted_move_hash.inspect
    end
  end

  def self.make_data(party,party_id)
    #全アイテム名の名称取得
    all_item_name = Item.pluck("name")
    #全技名の名称取得
    all_move_name = Move.pluck("name")

    #パーティメンバーそれぞれに対してチームメイト・持ち物・覚えている技のベクトルを持った個体dataを作成
    party.each do |member|
      #アイテム情報のハッシュ
      item_hash = {}
      #技情報のハッシュ
      move_hash = {}
      #対象ポケモンのid
      poke_id = Pokemon.where(name:member["name"]).first["poke_id"]
      #自分以外のメンバーのidをベクトル表現
      party_member_vector = Datum.party_member_vector(poke_id,party_id)

      #アイテムハッシュ作成
      all_item_name.each do |item_name|
        if item_name == member["item"]
          item_hash[item_name] = 1
        else
          item_hash[item_name] = 0
        end
      end

      #技ハッシュ作成
      all_move_name.each do |move_name|
        if member["move"].include?(move_name)
          move_hash[move_name] = 1
        else
          move_hash[move_name] = 0
        end
      end

      Pokemon.where(name:member["name"]).first.datum << Datum.new(
        :party_member => party_member_vector,
        :item => item_hash,
        :move => move_hash
        )
    end
  end

end
