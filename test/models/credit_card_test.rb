require 'test_helper'

class CreditCardTest < ActiveSupport::TestCase
  test "valid create" do
    credit_card = create(:credit_card)

    assert credit_card.persisted?
  end

  test "validations" do
    assert_validations(CreditCard.new, [:last_four, :month, :year, :user, :name])
  end
end
