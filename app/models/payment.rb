class Payment < ActiveRecord::Base
	belongs_to :credit_card,
						 inverse_of: :payments
end
