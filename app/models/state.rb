class State < ActiveRecord::Base
	has_many :addresses, inverse_of: :state
  validates_presence_of :name, :abbreviation
end
