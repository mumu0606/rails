class ChangeColumnDatum < ActiveRecord::Migration
  def change
    add_column :data, :p1, :integer
    add_column :data, :p2, :integer
    add_column :data, :p3, :integer
    add_column :data, :p4, :integer
    add_column :data, :p5, :integer
    add_column :data, :m1, :integer
    add_column :data, :m2, :integer
    add_column :data, :m3, :integer
    add_column :data, :m4, :integer

    remove_column :data, :party_member, :text
    remove_column :data, :item, :text
    remove_column :data, :move, :text
  end
end
