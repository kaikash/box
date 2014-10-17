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

  def delete(line)
    res = {}
    @providers.each do |provider_name, provider|
      line_to_delete = line.storages.joins(:provider).find_by("providers.name" => provider_name, state: "success")
      if line_to_delete
        res[provider_name] = provider.delete line_to_delete.post_id 
      else 
        res[provider_name] = {response: 1}.to_json
      end
    end
    res
  end
    
  def sync
    # sync
  end

  def initialize
    @providers = {fb: Providers::Fb.new, vk: Providers::Vk.new}
  end
end