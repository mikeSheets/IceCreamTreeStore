class Product < ActiveRecord::Base
	validates_presence_of :name, :permalink
	has_many :order_items, as: :source

  before_validation :set_permalink

  def set_permalink
    self.permalink = name.parameterize
  end
end
