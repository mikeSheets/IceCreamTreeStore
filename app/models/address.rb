class Address < ActiveRecord::Base
  belongs_to :state
  belongs_to :user
  has_many :orders, inverse_of: :address
  validates_presence_of :name, :line1, :line2, :city, :state, :zip, :user
end
