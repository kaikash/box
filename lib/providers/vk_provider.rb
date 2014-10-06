class Provider::Vk < Provider::Base
	@storage_id = "75576142"
	@access_token = "3bf52a682cf1a0c591582a2a49a6d4f63a4be9afe97303f29a023de8ed902ea2cdf6ca86cee332b322576"

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