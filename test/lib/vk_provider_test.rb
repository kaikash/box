require 'test_helper'
require "#{Rails.root}/lib/providers/base_provider"
require "#{Rails.root}/lib/providers/vk_provider"
class ProviderVkTest < ActiveSupport::TestCase
	setup do
		@provider = Provider::Vk.new
	end
	
	test "should post" do
		assert_not_nil JSON.parse(@provider.post)['response']
		assert_nil JSON.parse(@provider.post)['error']
	end

	test "should delete" do
		assert_not_nil JSON.parse(@provider.delete)['response']
		assert_nil JSON.parse(@provider.delete)['error']
	end

	test "should update" do
		assert_not_nil JSON.parse(@provider.update)['response']
		assert_nil JSON.parse(@provider.update)['error']
	end
end