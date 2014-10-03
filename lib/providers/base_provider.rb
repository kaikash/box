module Provider
	class Base
		def call(action, params)
			return {error:{error_msg: "Missing line", error_code: 1488}}.to_json if(!params[:line])
			method(self.class.name.split("::")[1].downcase+"_"+action.to_s + "_line").call(params[:line])
		end

		def vk_post_line(line)
			{response:{post_id: 1488}}.to_json
		end

		def vk_update_line(line)
			{response:{post_id: 1488}}.to_json
		end

		def vk_delete_line(line_id)
			{response: 1}.to_json
		end
	end
end