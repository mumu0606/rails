namespace :move_items do
  desc "insert data to move_items"
  task :insert_move_items => :environment do
    datum = Datum.all
    datum.each do |data|
      #move_itemテーブルへのアクセス
      #item_idとmove_idの取得
      item_id = Datum.get_itemid_from_data(data)
      move_ids = Datum.get_moveid_from_data(data) #技は4つのid
      item = Item.where(item_id:item_id).first
      move_ids.each do |move_id|
        move_item = item.move_items.find_or_create_by(
          :item_id => item_id,
          :move_id => move_id
          )
        #アイテムと技の共起度を計算
        cooccur = move_item['cooccur']
        if move_item['cooccur'] == nil
          cooccur = 1
        end
        move_item.update_attributes(
          :cooccur => cooccur + 1)
      end
    end
  end
end
