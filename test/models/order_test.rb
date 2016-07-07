require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "valid create" do
    order = create(:order)
    assert order.persisted?
  end

  test "placing an order" do
    order = create(:order)
    oi = create(:order_item, order: order)

    product = oi.source

    assert_difference("product.on_hand", -oi.quantity) do
      assert order.make_placed, order.errors
      product.reload
    end

  end
  # test "can't transition from cart to canceled" do
  #   puts Order.column_names
  #   order = build(:order)
  #   assert order.save, order.errors.inspect
  #   assert_equal Order::CART, order.state
  #
  #   order.state = Order::CANCELLED
  #
  #   assert_not order.save, order.errors.inspect
  #   puts order.errors.inspect
  #   assert_equal order.errors[:state], ["Cannot transition from cart to cancelled"]
  #
  # end
end
