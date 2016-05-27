require 'test_helper'

class OrderItemTest < ActiveSupport::TestCase
  test "valid create" do
		order_item = create(:order_item)
    assert order_item.persisted?
	end

	test "validations" do
		assert_validations(OrderItem.new, [:source, :order, :quantity])
	end
end
