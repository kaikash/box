class CreateStorages < ActiveRecord::Migration
  def change
    create_table :storages do |t|
      t.belongs_to :provider, index: true
    	t.text :params, default: {error: "Error"}.to_json
      t.string :state
      t.timestamps
    end
  end
end
