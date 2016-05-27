require 'test_helper'

class StatesTest < ActiveSupport::TestCase
  test "valid create" do
		state = create(:state)
    assert state.persisted?
	end

	test "validations" do
		assert_validations(State.new, [:name, :abbreviation])
	end



end
