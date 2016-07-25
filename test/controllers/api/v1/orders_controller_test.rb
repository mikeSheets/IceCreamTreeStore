require 'test_helper'

class Api::V1::OrdersControllerTest < ActionController::TestCase
  setup do
    @order = create(:order)
  end

  test "Get the cart!" do
    get :get_cart, { user_id: @order.user.id }
    assert_response :success
  end

  test "update the cart!" do
    post :update, id: @order.id
  end


end