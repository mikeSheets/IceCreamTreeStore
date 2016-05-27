require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "valid create" do
		user = create(:user)
    assert user.persisted?
	end

	test "validations" do
		assert_validations(User.new, [:name, :email, :password])

    user = User.new(password: "something", password_confirmation: "asdf")
    assert_not user.save

    assert_equal ['doesn\'t match Password'], user.errors[:password_confirmation]
	end
end
