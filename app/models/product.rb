class Product < ActiveRecord::Base
	validates_presence_of :name, :permalink
	belongs_to OrderItem, polymorphic: true
end
