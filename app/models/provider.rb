class Provider < ActiveRecord::Base
	has_many :storages
  def name
    type.downcase.to_sym
  end
end