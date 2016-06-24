class Order < ActiveRecord::Base
  belongs_to :user, inverse_of: :orders
  has_many :order_items, inverse_of: :order
  belongs_to :address
  has_one :payment

  CART = "cart"
  PLACED = "placed"
  CANCELLED = "cancelled"

  STATES = [CART, PLACED, CANCELLED]
  validates(:state, inclusion: STATES)

  before_save :validate_state_change

  after_initialize :set_default_state

  # TODO - state machine

  def serializable_hash(options={})
    {
      product_count: order_items.where(source_type: Product.name).sum(:quantity),
      order_items: order_items.map(&:serializable_hash)
    }.merge(super(options))
  end

  def validate_state_change
    old = changed_attributes["state"]
    newb = state
    old_index = STATES.index(old)
    new_index = STATES.index(newb)


    if !persisted?
      errors.add(:state, "initial state must be #{STATES.first}") if self.state != STATES.first
    elsif new_index.nil?
      errors.add(:state, "#{newb} is not a valid state")
    elsif new_index != (old_index + 1)
      errors.add(:state, "Cannot transition from #{newb} to #{old}")
    end
    errors.empty?
  end

  def set_default_state
    self.state ||= STATES.first
  end

end

