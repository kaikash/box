class Provider < ActiveRecord::Base
	has_many :storages
  def name
    type.downcase.to_sym
  end

  def post
    error
  end

  def update
    error
  end

  def delete
    error
  end

  def get
    error
  end

  def get_all
    error
  end

  private
  def error
    raise 'error'
  end
end