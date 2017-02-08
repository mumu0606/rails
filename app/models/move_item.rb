class MoveItem < ActiveRecord::Base
  belongs_to :move
  belongs_to :item
  self.primary_keys = :move_id,:item_id

  #単なる協調フィルタリングでアイテムと技名の関連性を考えないとこだわりスカーフをもたせているのにみがわりとか「とつげきチョッキ」を持たせているのに「はらだいこ」とか起こってしまうので技の予想確立にアイテムとの共起度の下駄をはかせる・アイテムに対して技が何回共起しているかを計算しitem_moveテーブルにつっこむ．パーティー情報（Dataクラス）を作成するときに行うべき．引数は新規のdata

  #pokemon_infoからアイテム・技の共起度を更新
end
