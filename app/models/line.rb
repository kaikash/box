class Line < ActiveRecord::Base
	validates :name, presence: true
	mount_uploader :img, Uploader
	after_create do
		update_attribute :order_num, id
	end
end
