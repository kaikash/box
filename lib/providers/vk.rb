module Providers 
  class Vk < Providers::Base
  	def initialize
  		@storage_id = Rails.application.secrets.vk_storage_id
  		@access_token = Rails.application.secrets.vk_access_token
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

    private
  	def query(method, params)
  		url = "https://api.vk.com/method/#{method}?#{parseParams params}"
      uri = URI(URI::encode(url))
      req = Net::HTTP::Get.new(uri.request_uri)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER
      res = http.request req
      JSON.parse(res.body)
  	end

  	def load_img(img)
  	end

    def parseParams(params)
      res = params.map do |key, value|
        "#{key}=#{value}"
      end
      res.join "&"
    end
  end
end