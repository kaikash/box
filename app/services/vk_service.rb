class VkService < BaseService
  class << self
    def name
      :vk
    end
    def post(line)
      params = {access_token: access_token, owner_id: storage_id, message: line.name, from_group: 1}
      if line.img.file
        img_path = load_img line.img
        params[:attachments] = img_path
      end
      res = query "wall.post", params
    end

    def get(post_id)
      params = {access_token: access_token, posts: form_post_id(post_id)}
      p = query("wall.getById", params)
      if p['response'] == [] || p['error']
        return false
      end
      true
    end

    def get_all_ids
      params = {access_token: access_token, owner_id: storage_id}
      q = query("wall.get", params)
      return [] if q['error']
      res = q['response'][1..-1].map {|post| post['id']}
    end

    def update(line)
      # params = { line: line }
      # call :update, params
    end

    def delete(post_id)
      params = {post_id: post_id, access_token: access_token, owner_id: storage_id}
      query "wall.delete", params
    end

    def query(method, params)
      params[:version] = api_version
      url = "https://api.vk.com/method/#{method}?#{parse_params params}"
      # raise url
      uri = URI(URI::encode(url))
      req = Net::HTTP::Get.new(uri.request_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      res = http.request req
      JSON.parse(res.body)
    end

    private
    def form_post_id(post_id)
      "#{storage_id}_#{post_id}"
    end

    def load_img(img)
      # Code..
    end

    def api_version
      "5.27"
    end

    def parse_params(params)
      res = params.map do |key, value|
        "#{key}=#{value}"
      end
      res.join "&"
    end

    def storage_id
      Rails.application.secrets.vk_storage_id
    end

    def access_token
      Rails.application.secrets.vk_access_token
    end
  end
end