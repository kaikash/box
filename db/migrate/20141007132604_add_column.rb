class AddColumn < ActiveRecord::Migration
  def change
  	add_column :lines, :provider_ids, :text
  end
end
