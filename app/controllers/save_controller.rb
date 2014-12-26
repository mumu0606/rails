class SaveController < ApplicationController
  autocomplete :pokemon,:name, :full => true
  autocomplete :item,:name, :full => true
  autocomplete :move,:name, :full => true

  PARTY_SIZE = 6

  def save_data
    #パーティーの情報を格納する
    party = []
    #パーティーのpoke_idを格納する
    party_id = []

    if request.post?
      #raise params.inspect
      for i in 0..PARTY_SIZE - 1 do
        pokemon = {}
        if params["pokemon"][i] != ""
          pokemon["name"] = params["pokemon"][i]
          pokemon["item"] = params["item"][i]
          pokemon["move"] = [params["move"][i * 4],params["move"][i * 4 + 1],params["move"][i * 4 + 2],params["move"][i * 4 + 3]]
          party.push(pokemon)
          party_id.push(Pokemon.where(name:pokemon["name"]).first["poke_id"])
        end
      end
    end

    Datum.make_data(party,party_id)
  end
end
