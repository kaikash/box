class Storage < ActiveRecord::Base
	has_and_belongs_to_many :lines
	belongs_to :provider
	validates :state, presence: true
	# def params_obj
	# 	JSON.parse(self.params)
	# end
	# def params_obj=(val)
	# 	self.params = val.to_json
	# end
end
