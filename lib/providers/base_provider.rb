require "#{Rails.root}/lib/providers/api_provider"

module Provider
	class Base
		def call(action, params)
			return {error:{error_msg: "Missing line", error_code: 1488}}.to_json if(!params[:line])
			method(action.to_s + "_line").call(self.class.name.split("::")[1].downcase.to_sym, params[:line])
		end

		def post_line(provider, line)
			case provider
				when :vk
					params = {attachments: [], access_token: @access_token, storage_id: @storage_id, message: line.name}
					if line.img
            photo_path = ::Provider::API.load_img(:vk, line.img)
						params[:attachments] = img_path
					end
					res = ::Provider::API.query(:vk, "wall.post", params)
				when :fb
          params = {access_token: @access_token, storage_id: @storage_id, message: line.name, type: :feed}
          if line.img
            params[:type] = photos
          end
          res = ::Provider::API.query(:fb, :post, params)
			end
			res
		end

		def update_line(provider, line)
			case provider
				when :vk
					{response:{post_id: 1488}}.to_json
				when :fb
			end
		end

		def delete_line(provider, line_id)
			params = {post_id: line_id}
			method = case provider
				when :vk
					"wall.delete"
				when :fb
					:delete
				end
				::Provider::API.query(provider, method, params)
		end
	end
end
