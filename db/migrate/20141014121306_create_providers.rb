class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.string :type, unique: true
    	t.timestamps
    end
  end
end
