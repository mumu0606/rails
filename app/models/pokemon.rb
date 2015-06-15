class Pokemon < ActiveRecord::Base
  self.primary_key = :poke_id
  has_many :datum

  #パーティが入力されたとき各ポケモンが正しいポケモン名かを判定する
  #パーティを配列で与え間違っているポケモン名を配列で返す
  #["サーナイト","ラティオス"] → []
  #["サーナイト","ランドロス"] → ["ランドロス"]
  def self.validate_name(party_name)
    false_names = []
    poke_names = Pokemon.pluck(:name)
    party_name.each do |poke_name|
      false_names.push(poke_name) if not poke_names.include?(poke_name)
    end
    return false_names
  end

end
