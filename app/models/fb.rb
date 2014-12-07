class Fb < Provider
  def post(line)
    params = {access_token: access_token, storage_id: storage_id, message: line.name, type: :feed}
    if line.img.file
      params[:type] = :photos
      photo_path = load_img line.img
      params[:picture] = photo_path
    end
    res = query :post, params
  end

  def update(line)
    # params = { line: line }
    # call :update, params
  end

  def get_all_ids
    params = {access_token: access_token, post_id: "#{storage_id}/feed"}
    q = query(:get, params)
    return [] if q['error']
    res = q['data'].map do |post|
      if post['from']['id'] == user_id.to_s
        if post['post_id']
          post['post_id']
        else
          post['id']
        end
      end
    end
    res
  end

  def get(post_id)
    params = {access_token: access_token, post_id: post_id}
    p = query(:get, params)
    if p['error']
      return false
    end
    true
  end

  def delete(post_id)
    params = {post_id: post_id, access_token: access_token}
    query :delete, params
  end

  def query(method, params)
    case method
    when :get
      url = "https://graph.facebook.com/#{api_version}/#{params[:post_id]}?access_token=#{params[:access_token]}"
      # raise url
      uri = URI(URI::encode(url))
      req = Net::HTTP::Get.new(uri.request_uri)
    when :post
      url = "https://graph.facebook.com/#{api_version}/#{params[:storage_id]}/#{params[:type]}?access_token=#{params[:access_token]}"
      # raise url
      uri = URI(URI::encode(url))
      req = Net::HTTP::Post.new(uri.request_uri)
      pars = {message: params[:message]}
      pars[:picture] = params[:picture] if params[:picture]
      req.set_form_data(pars)
    when :delete
      url = "https://graph.facebook.com/#{api_version}/#{params[:post_id]}?access_token=#{params[:access_token]}"
      uri = URI(URI::encode(url))
      req = Net::HTTP::Delete.new(uri.request_uri)
    end
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    res = http.request req
    JSON.parse(res.body)
  end

  private
  def load_img(img)
    # Code..
  end

  def api_version
    "v2.2"
  end

  def user_id
    Rails.application.secrets.fb_user_id
  end

  def storage_id
    Rails.application.secrets.fb_storage_id
  end

  def access_token
    Rails.application.secrets.fb_access_token
  end
end