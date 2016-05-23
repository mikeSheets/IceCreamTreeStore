class OrderItem < ActiveRecord::Base
	belongs_to :order,
						 inverse_of: :order_items
end
