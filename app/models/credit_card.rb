class CreditCard < ActiveRecord::Base
	belongs_to :user
	has_many :payments,
		inverse_of: :credit_card
end
