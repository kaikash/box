module Provider
	class Base
		def call(action, params)
			return {error:{error_msg: "Missing line", error_code: 1488}}.to_json if(!params[:line])
			method(action.to_s + "_line").call(self.class.name.split("::")[1].downcase.to_sym, params[:line])
		end

		def post_line(provider, line)
			switch(provider)
				when :vk
					params = {attachments: [], access_token: @access_token, storage_id: @storage_id}
					if line.img
						# params[:attachments] PHOTOPATH
					end
					res = Provider::API.query(:vk, "wall.post", params)
					# {response:{post_id: 1488}}.to_json
				when :fb
          params = {access_token: @access_token, storage_id: @storage_id, }
          if line.img
            # params[:attachments] PHOTOPATH
          end
          res = Provider::API.query(:fb, :post, params)
			end
			res
		end

		def update_line(provider, line)
			switch(provider)
				when :vk
					{response:{post_id: 1488}}.to_json
				when :fb
			end
		end

		def delete_line(provider, line_id)
			switch(provider)
				when :vk
					{response: 1}.to_json
				when :fb
			end
		end
	end
end