require 'test_helper'

class Api::V1::OrderItemsControllerTest < ActionController::TestCase

  setup do
    @product = create(:product)
    @order = create(:order)
    sign_in @order.user
  end

  test "should add to cart" do
    attrs = attributes_for(:order_item, source_id: @product.id, source_type: Product.name, order_id: @order.id, quantity: 1)
    post :create, order_item: attrs

    assert_response :success
  end

  test "should remove item from cart" do
    attrs = attributes_for(:order_item, source_id: @product.id, source_type: Product.name, order_id: @order.id, quantity: 0)
    post :create, order_item: attrs

    assert_response :success
  end
end