require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup do
    @product = create(:product)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get product show" do
    get :show, { id: @product.id }
    assert_response :success
  end
end
