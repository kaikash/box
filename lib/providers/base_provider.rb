module Provider
	class Base
		def call(action, params)
			return {error:{error_msg: "Missing line", error_code: 1488}}.to_json if(!params[:line])
			method(action.to_s + "_line").call(self.class.name.split("::")[1].downcase.to_sym, params[:line])
		end

		def post_line(provider, line)
			switch(provider)
				when :vk
					{response:{post_id: 1488}}.to_json
				when :fb
			end
		end

		def update_line(provider, line)
			switch(provider)
				when :vk
					{response:{post_id: 1488}}.to_json
			end
		end

		def delete_line(provider, line_id)
			switch(provider)
				when :vk
					{response: 1}.to_json
			end
		end
	end
end