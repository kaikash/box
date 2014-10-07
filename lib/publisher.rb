require 'singleton'
class Publisher 
  include Singleton

  def post(line)
    res = {}
    @providers.each do |provider_name, provider|
      res[provider_name] = provider.post line
    end
    res
  end

  def update(line)
    res = {}
    @providers.each do |provider_name, provider|
      res[provider_name] = provider.update line
    end
    res
  end

  def delete(line_id)
    res = {}
    @providers.each do |provider_name, provider|
      res[provider_name] = provider.delete line_id
    end
    res
  end
    
  def alala
    @providers
  end

  def initialize
    @providers = {fb: Providers::Fb.new, vk: Providers::Vk.new}
  end
end