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
    res
  end
    
  def sync(lines)
    lines.each do |line|
      line.storages.each do |s|
        unless s.provider.get s.post_id
          new_post = s.provider.post line
          if new_post['error']
            s.state = "error"
            s.post_id = nil
          else
            s.post_id = s.provider.type == "Vk" ? new_post['response']['post_id'] : line.img.file ? new_post['post_id'] : new_post['id']
            s.state = "success"
          end
        end
        s.save
      end
    end

    providers.each do |p|
      p.get_all_ids.each do |remote_post_id|
        l = Line.joins(:storages).where(storages: {post_id: remote_post_id, provider_id: p.id}).any?
        p.delete remote_post_id unless l
      end
    end
  end

  def initialize
  end

  private
  def providers
    @providers ||= Provider.all
  end

end