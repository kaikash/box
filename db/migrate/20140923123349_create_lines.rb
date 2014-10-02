class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.text :name
      t.string :img
      t.string :fb_id
      t.string :vk_id
      t.float :order_num

      t.timestamps
    end
  end
end
