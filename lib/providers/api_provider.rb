class Providers::API
	def query(provider, method, params)
    case provider
      when :vk
        url = "https:/api.vk.com/methdod/#{method}?#{parseParams params}"
        uri = URI(URI::encode(url))
        req = Net::HTTP::Get.new(uri.request_uri)
      when :fb
        case method
          when :post
            pars = params
            pars.delete :storage_id
            pars.delete :type
            pars.delete :access_token
            url = "https://graph.facebook.com/v2.1/#{params[:storage_id]}/#{params[:type]}?access_token=#{params[:access_token]}"
            uri = URI(URI::endcode(url))
            req = Net::HTTP::Post.new(uri.request_uri)
            req.set_form_data pars
        end
        http = Net::HTTP.new(uri.host, uri.port)
        res = http.request req
    end
    res
	end

  def load_img(provider, img)
    # code
  end

  private
    def parseParams(params)
      res = params.map do |key, value|
        "#{key} = #{value}"
      end
      res.join "&"
    end
end
