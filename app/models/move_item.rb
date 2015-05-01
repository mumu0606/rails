class MoveItem < ActiveRecord::Base
  belongs_to :move
  belongs_to :item
  self.primary_keys = :move_id,:item_id

  #単なる協調フィルタリングでアイテムと技名の関連性を考えないとこだわりスカーフをもたせているのにみがわりとか「とつげきチョッキ」を持たせているのに「はらだいこ」とか起こってしまうので技の予想確立にアイテムとの共起度の下駄をはかせる・アイテムに対して技が何回共起しているかを計算しitem_moveテーブルにつっこむ．パーティー情報（Dataクラス）を作成するときに行うべき．引数は新規のdata
  def self.calculate_count_with(new_data)
    item_id = Datum.get_itemid_from_data(new_data)
    move_ids = Datum.get_moveid_from_data(new_data)
    move_ids.each do |move_id|
      item = Item.where(item_id:item_id).first
      move = Move.where(move_id:move_id).first
      #アイテム・技の組み合わせが新規なら1に,それ以外なら+1
      move_item = item.move_items.find_or_initialize_by(move_id:move_id)
      if move_item.new_record?
        move_item.update_attributes(
          :cooccur => 1)
      else
        move_item.update_attributes(
          :cooccur => move_item['cooccur'] + 1)
      end
    end
  end

end
