module Providers
	class Base
		def call(action, params)
			return {error:{error_msg: "Missing line", error_code: 1488}}.to_json if(!params[:line])
			method(action.to_s + "_line").call(self.class.name.split("::")[1].downcase.to_sym, params[:line])
		end

		def post_line(provider, line)
			case provider
				when :vk
					params = {access_token: @access_token, owner_id: @storage_id, message: line.name, from_group: 1}
					if line.img.file
            photo_path = load_img line.img
						params[:attachments] = img_path
					end
					res = query "wall.post", params
				when :fb
          params = {access_token: @access_token, storage_id: @storage_id, message: line.name, type: :feed}
          if line.img.file
            params[:type] = :photos
          end
          res = query(:post, params)
			end
			res
		end

		def query
			raise 'reuse'
		end

		def update_line(provider, line)
			case provider
				when :vk
					{response:{post_id: 1488}}.to_json
				when :fb
					{response:{post_id: 1488}}.to_json
			end
		end

		def delete_line(provider, line_id)
			params = {post_id: line_id, access_token: @access_token, owner_id: @storage_id}
			method = case provider
				when :vk
					"wall.delete"
				when :fb
					:delete
				end
			query(method, params)
		end
	end
end
