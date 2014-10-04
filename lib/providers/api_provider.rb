class Providers::API
	def query(provider, method, params)
    # url = getHost(provider)
    switch(provider)
      when :vk
        url = "https:/api.vk.com/methdod/#{method}?#{parseParams params}"
        uri = URI(URI::encode(url))
        res = Net::HTTP.get_response(uri)
      when :fb
        switch(method)
          # url = "https:/api.vk.com/methdod/#{method}?#{parseParams params}"
          # uri = URI(URI::encode(url))
          # res = Net::HTTP.get_response(uri)
          
        end
    end
    res
	end

  private
    def parseParams(params)
      res = params.map_with_index do |param, value| # что-то тут мап виф индекс
        "#{param} = #{value}"
      end
      res.join "&"
    end
end
