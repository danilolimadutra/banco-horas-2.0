require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  def setup
    @category = Category.create(name: "sports")
  end
  
  test "deve acessar categories index" do
    get :index
    assert_response :success
  end
  
  test "deve acessar categories new" do
    get :new
    assert_response :success
  end
  
  test "deve acessar categories show" do
    get(:show, {'id' => @category.id})
    assert_response :success
  end
end