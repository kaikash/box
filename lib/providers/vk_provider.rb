class Provider::Vk < Provider::Base
	@storage_id = "75576142"
	@access_token = "e955792857a63ae29d4a2a66df1bfd35f4c8b9d085382f91c85c012143087957fcbe7230c7fbbf0cf8634"

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