require 'singleton'
class Publisher 
  include Singleton

  def post(line)
    res = {}
    providers.each do |p|
      res[p.name] = p.post line
    end
    res
  end

  def update(line)
    res = {}

    # @providers.each do |provider_name, provider|
      # res[provider_name] = provider.update line
    # end
    res
  end

  def delete(line)
    res = {}
    line.storages.where(state: :success).each do |s|
      res[s.provider.name] = s.provider.delete s.post_id    
    end

    # @providers.each do |provider_name, provider|
    #   line_to_delete = line.storages.where(state: :success).select { |s| s.provider.name == provider_name }
    #   raise line_to_delete.post_id
    #   if line_to_delete
    #     res[provider_name] = provider.delete line_to_delete.post_id 
    #   else 
    #     res[provider_name] = {response: 1}.to_json
    #   end
    # end
    res
  end
    
  def sync
    # sync
  end

  def initialize
    # @providers = {fb: Providers::Fb.new, vk: Providers::Vk.new}
  end

  private
  def providers
    @providers ||= Provider.all
  end

end