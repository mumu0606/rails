POKE_ITEM_URL = 'db/seed/item/poke_item.json'

def insert_item
  open(POKE_ITEM_URL) do |f|
    Item.transaction do
      while l = f.gets
        item = Item.new.from_json(l)
        item.save
      end
    end
  end
end

insert_item
