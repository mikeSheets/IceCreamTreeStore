require 'test_helper'

class Api::V1::CreditCardsControllerTest < ActionController::TestCase

  setup do
    @credit_card = create(:credit_card)
    sign_in @credit_card.user
  end

  test "created credit card" do
    attrs = attributes_for(:credit_card, last_four: @credit_card.last_four, month: @credit_card.month, year: @credit_card.year, user_id: @credit_card.user_id, name: @credit_card.name, number: @credit_card.number, cvc: @credit_card.cvc)
    post :create, credit_card: attrs
    assert_response :success
  end

  test "updated credit card" do
    @credit_card.name = "Squidward"
    post :update, id: @credit_card.id, credit_card: @credit_card.as_json
    assert_response :success
  end
end