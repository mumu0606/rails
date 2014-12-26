class PageController < ApplicationController
  autocomplete :pokemon,:name, :full => true
  autocomplete :item,:name, :full => true
  autocomplete :move,:name, :full => true

  PARTY_SIZE = 6
  POKEMON_ZUKAN_SIZE = 719
  def title
    datum = []
    #poke_idで表現されたパーティーの情報を格納する
    party_id = []
    #類似度計算で予測されたパーティ情報
    predicted_party = []

    if request.post?
      params["name"].each do |name|
        party_id.push(Pokemon.where(name:name).first["poke_id"])
      end
    end
    
    party_id.each do |poke_id|
      Datum.predict_itemove(poke_id,party_id)
    end
  end
end
