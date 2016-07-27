ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'



class ActiveSupport::TestCase
  require 'factories'
  include FactoryGirl::Syntax::Methods

  def assert_validations(model, fields)

    assert_not model.save, "Did save."

    # puts model.errors.inspect

    fields.each do |field|
      assert_equal ["can't be blank"], model.errors[field].uniq, "#{field} should not be empty"

    end
    # assert_equal fields.count, model.errors.count, model.errors.inspect
  end
end
class ActionController::TestCase
  include Devise::TestHelpers

  def teardown
    # make sure nobody is left signed in
    sign_out :user
    super
  end
end
