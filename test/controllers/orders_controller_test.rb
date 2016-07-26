require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
  setup do
    @order_item = create(:order_item)
    @order = Order.find_by(id: @order_item.order_id)
    @user = User.find_by(id: @order.user_id)
    @payment = create(:payment)
    @order.payment = @payment
    sign_in @user
  end

  test "should get order show" do
    @order.state = 'placed'
    get :show, { id: @order.id}
    assert_response :success
  end
end