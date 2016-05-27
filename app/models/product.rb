class Product < ActiveRecord::Base
	validates_presence_of :name, :permalink
	has_many :order_items, as: :source
end
