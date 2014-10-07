require 'test_helper'
require "#{Rails.root}/lib/providers/base_provider"
require "#{Rails.root}/lib/providers/vk_provider"
class ProviderVkTest < ActiveSupport::TestCase
	setup do
		@provider = Provider::Vk.new
		@line = lines :one
	end

	test "should delete" do
    post_id = @provider.post(@line)['response']['post_id']
    delete = @provider.delete post_id
    assert_not_nil delete['response']
		assert_nil delete['error']
	end

	test "should update" do
		update = @provider.update @line
		assert_not_nil update['response']
		assert_nil update['error']
	end

  test "should post" do
    post = @provider.post @line
    assert_not_nil post['response']
    assert_nil post['error']
  end
end