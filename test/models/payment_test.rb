require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  test "valid create" do
		payment = create(:payment)
    assert payment.persisted?
	end

	test "validations" do
		assert_validations(Payment.new, [:amount, :order, :credit_card])
	end

  # test "can't transition from pending to voided" do
  #   puts Payment.column_names
  #   payment = build(:payment)
  #   assert payment.save, payment.errors.inspect
  #   assert_equal payment::PENDING, payment.state
  #
  #   payment.state = Payment::VOIDED
  #
  #   assert_not order.save, order.errors.inspect
  #   puts order.errors.inspect
  #   assert_equal order.errors[:state], ["Cannot transition from pending to voided."]
  #
  # end
end
