class CreateLinesStorages < ActiveRecord::Migration
  def change
    create_table :lines_storages, id: false do |t|
    	t.belongs_to :line, index: true
    	t.belongs_to :storage, index: true
    end
  end
end
