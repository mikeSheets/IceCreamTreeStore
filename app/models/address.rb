class Address < ActiveRecord::Base
	has_one :state
	belongs_to :user
	has_many :orders,
		inverse_of: :address
end
