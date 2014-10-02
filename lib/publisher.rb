require 'singleton'

class Publisher 
  include Singleton
  @providers = [Provider::FB.new, Provider::VK.new]

  def post(line)
    @providers.each { |provider| provider.post line }
  end

  def update(line)
    @providers.each { |provider| provider.update line }
  end

  def delete(line)
    @providers.each { |provider| provider.delete line }
  end
end