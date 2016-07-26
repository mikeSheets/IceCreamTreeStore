require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "valid create" do
    order = create(:order)
    assert order.persisted?
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
