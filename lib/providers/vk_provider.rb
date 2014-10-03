class Provider::Vk < Provider::Base
	@storage_id = "75576142"
	@access_token = ""

	def initialize
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
end