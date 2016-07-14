class Order < ActiveRecord::Base
  belongs_to :user, inverse_of: :orders
  has_many :order_items, inverse_of: :order
  belongs_to :address
  has_one :payment

  attr_accessor :credit_card_id

  self.state_machine({
      cart: [:placed],
      placed: [:cancelled],
      cancelled: []
  })

  before_transition_to :placed do

    # TODO set address to user.address, if no user.address add validation and return false

    unless address = user.address
      address.save
    else
      errors[:base] << address.errors.map{|k, v| "Cannot place order with no address. #{k}:  #{v}"}
      return false if errors.present?
    end

    if order_items.to_a.sum{|x| x.quantity} == 0
      errors[:base] << "Cannot place an order with no items."
      return false if errors.present?
    end
    order_items.each do |item|
      if item.source.on_hand >= item.quantity
        puts "#{item.source.name} is good to go."
      else
        errors[:base] << "#{item.source.name} does not have enough available inventory. Only #{item.source.on_hand} left."
        item.update(quantity: item.source.on_hand)
      end
    end

    return false if errors.present?

    order_items.each do |item|
      item.source.on_hand -= item.quantity
      item.source.save
    end

    order_total = order_items.to_a.sum{|x| x.source.price * x.quantity}
    payment = Payment.find_or_initialize_by(credit_card_id: credit_card_id, order_id: id, state: Payment::PENDING)
    payment.amount = order_total
    unless payment.save
      errors[:base] << payment.errors.map{|k, v| "Payment Error #{k}: #{v}"}
    end
    unless payment.make_completed
      errors[:base] << payment.errors.map{|k, v| "Payment Error #{k}: #{v}"}
    end
    errors.empty?
  end

  def serializable_hash(options={})
    {
      product_count: order_items.where(source_type: Product.name).sum(:quantity),
      order_items: order_items.map(&:serializable_hash)
    }.merge(super(options))
  end

end

