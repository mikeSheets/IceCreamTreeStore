require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "valid create" do

		product = create(:product)
		assert product.persisted?
	end

	test "validations" do
		assert_validations(Product.new, [:name, :permalink])
	end
end
