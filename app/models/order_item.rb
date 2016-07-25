class OrderItem < ActiveRecord::Base
  belongs_to :order, inverse_of: :order_items
  belongs_to :source, polymorphic: true
  validates_presence_of :source, :order, :quantity

  def price
    source.price
  end

  def serializable_hash(options={})
    puts self.inspect
    puts "#{self.persisted?} source_id = #{source_id}, source_type = #{source_type}"
    {
      source: source.serializable_hash
    }.merge(super(options))
  end

end
