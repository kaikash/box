require 'test_helper'

class LineControllerTest < ActionController::TestCase
  setup do
    @controller = LinesController.new
    @line = lines :one
  end

  test "should get index" do
  	get :index
  	assert_response :success
  	assert_not_nil assigns :lines
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line
    assert_response :success
  end

  test "should update line" do
    patch :update, id: @line, line: {name: @line.name, img: @line.img}
    assert_redirected_to lines_path
  end

  test "should create line" do
    assert_difference('Line.count') do 
      post :create, line: { img: @line.img, name: @line.name } 
    end 
    assert_redirected_to lines_path
  end

  test "should sort lines" do
    sec_line = lines :two
    patch :sort
    assert_not_equal @line, assigns(:lines)[0]
    assert_not_equal sec_line, assigns(:lines)[1]
    assert_redirected_to lines_path
  end

  test "should destroy line" do
    assert_difference('Line.count', -1) do
      delete :destroy, id: @line
    end

    assert_redirected_to lines_path
  end
end





