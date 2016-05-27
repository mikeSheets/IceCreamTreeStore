class OrderItem < ActiveRecord::Base
  belongs_to :order, inverse_of: :order_items
  belongs_to :source, polymorphic: true
  validates_presence_of :source, :order, :quantity
end
