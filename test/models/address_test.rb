require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  test "valid create" do
		address = create(:address)
    assert address.persisted?
	end

	test "validations" do
		assert_validations(Address.new, [:line1, :city, :state, :zip, :user])
	end
end
