class Order < ActiveRecord::Base
	belongs_to :user,
						 inverse_of: :orders
	has_many :order_items,
			inverse_of: :order
	has_one :address
	has_one :payment

end
