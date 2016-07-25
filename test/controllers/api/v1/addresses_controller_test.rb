require 'test_helper'

class Api::V1::AddressesControllerTest < ActionController::TestCase

  setup do
    @address = create(:address)
    sign_in @address.user
  end

  test "created address" do
    attrs = attributes_for(:address, name: @address.name, line1: @address.line1, line2: @address.line2, city: @address.city, state_id: @address.state_id, zip: @address.zip, user_id: @address.user.id)
    post :create, address: attrs
    assert_response :success
  end

  test "updated address" do
    @address.name = "Squidward"
    post :update, id: @address.id, address: @address.as_json
    assert_response :success
  end
end