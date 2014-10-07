class Provider::Fb < Provider::Base
	def initialize
		@storage_id = Rails.application.secrets.fb_storage_id
		@access_token = Rails.application.secrets.fb_access_token
	end

	def post(line)
		params = { line: line }
		call :post, params
	end

	def update(line)
		params = { line: line }
		call :update, params
	end

	def delete(line_id)
		params = { line: line_id }
		call :delete, params
	end

	def query(method, params)
		case method
    when :post
      url = "https://graph.facebook.com/v2.1/#{params[:storage_id]}/#{params[:type]}?access_token=#{params[:access_token]}"
      uri = URI(URI::encode(url))
      req = Net::HTTP::Post.new(uri.request_uri)
      req.set_form_data({message: params[:message]})
    when :delete
      url = "https://graph.facebook.com/v2.1/#{params[:post_id]}?access_token=#{params[:access_token]}"
      uri = URI(URI::encode(url))
      req = Net::HTTP::Delete.new(uri.request_uri)
    end
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    res = http.request req
    JSON.parse(res.body)
	end
end