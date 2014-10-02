class Provider::Vk < Provider::Base
	@storage_id = ""

	def initialize
	end

	def post(line)
		params = { line: line }
		call :post, params
	end

	def update(line)

	end

	def delete(line_id)
	end
end