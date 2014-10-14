class Line < ActiveRecord::Base
	has_and_belongs_to_many :storages
	validates :name, presence: true
	mount_uploader :img, Uploader
	after_create do
		update_attribute :order_num, id
	end
end
