ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'


class ActiveSupport::TestCase
  require 'factories'
  include FactoryGirl::Syntax::Methods

  def assert_validations(model, fields)

    assert_not model.save

    fields.each do |field|
      assert_equal ["can't be blank"], model.errors[field], "#{field} should be empty"

    end
    assert_equal fields.count, model.errors.count
  end
end
