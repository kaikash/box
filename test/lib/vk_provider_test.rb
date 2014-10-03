require 'test_helper'
require "#{Rails.root}/lib/providers/base_provider"
require "#{Rails.root}/lib/providers/vk_provider"
class ProviderVkTest < ActiveSupport::TestCase
	setup do
		@provider = Provider::Vk.new
		@line = lines :one
	end
	
	test "should post" do
		post = @provider.post @line
		assert_not_nil JSON.parse(post)['response']
		assert_nil JSON.parse(post)['error']
	end

	test "should delete" do
		delete = @provider.delete @line.id 
		assert_not_nil JSON.parse(delete)['response']
		assert_nil JSON.parse(delete)['error']
	end

	test "should update" do
		update = @provider.update @line
		assert_not_nil JSON.parse(update)['response']
		assert_nil JSON.parse(update)['error']
	end
end