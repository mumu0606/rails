class PageController < ApplicationController
  layout 'mylayout'
  autocomplete :pokemon,:name, :full => true
  autocomplete :item,:name, :full => true
  autocomplete :move,:name, :full => true

  PARTY_SIZE = 6
  POKEMON_ZUKAN_SIZE = 719
  def login_page
    datum = []
    #poke_idで表現されたパーティーの情報を格納する
    party_id = []
    #類似度計算で予測されたパーティ情報
    predicted_party = []

    if request.post?
      false_names = Pokemon.validate_name(params["name"])
      if false_names.length > 0
        flash[:alert] = "ポケモン名が間違っています" + false_names.join
        redirect_to :action => "title"
      else
        params["name"].each do |name|
          party_id.push(Pokemon.where(name:name).first["poke_id"])
        end
      end
    end

    @predicted_hash = {}

    party_id.each_with_index do |poke_id,i|
      @predicted_hash[params["name"][i]] = Datum.predict_itemove(poke_id,party_id)
    end
    #ログインしていたらタイトル画面にリダイレクト
    if user_signed_in?
      redirect_to :controller => "page",:action => "title"
    end
  end

  def top
  end

  def register
    #パーティーの情報を格納する
    party = []
    #パーティーのpoke_idを格納する
    party_id = []

    if request.post?
      for i in 0..PARTY_SIZE - 1 do
        pokemon = {}
        if params["pokemon"][i].present?
          unless Pokemon.where(name:params["pokemon"][i]).present?
            flash[:notice] = "ポケモン名があやまっています：#{params["pokemon"][i]}"
            return nil
          else
            pokemon["name"] = params["pokemon"][i]
          end
          if params["item"][i].present?
            unless Item.where(name:params["item"][i]).present?
              flash[:notice] = "アイテム名があやまっています：#{params["item"][i]}"
              return nil
            else
              pokemon["item"] = params["item"][i]
            end
          end
          if params["item"][i].present?
            unless Item.where(name:params["item"][i]).present?
              flash[:notice] = "アイテム名があやまっています：#{params["item"][i]}"
              return nil
            else
              pokemon["item"] = params["item"][i]
            end
          end
          pokemon["move"] = [params["move"][i * 4],params["move"][i * 4 + 1],params["move"][i * 4 + 2],params["move"][i * 4 + 3]]
          party.push(pokemon)
          party_id.push(Pokemon.where(name:pokemon["name"]).first["poke_id"])
        end
      end
      Data.make_data(party,party_id)
    end
  end

  def analysis
  end

  def rate_data
    #日ごとのレート遷移グラフを出す
    #レートのシーズン毎にwhereで適当にとって．created_atを見る
    #[d1,d2,d3,d4,,,,,,d5]
    @rate_data = [1500,1600,1700,1800,1900,2000,2100]
  end

  def battle_data
    #こちらの選出と相手の選出と勝敗を試合毎に表示
    #rowはs1,s2,s3,o1,o2,o3,result,created_at
    #1週間毎に出す
  end
end
