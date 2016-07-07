class Order < ActiveRecord::Base
  belongs_to :user, inverse_of: :orders
  has_many :order_items, inverse_of: :order
  belongs_to :address
  has_one :payment



  self.state_machine({
      cart: [:placed],
      placed: [:cancelled],
      cancelled: []
  })

  before_transition_to :placed do |from, to|

    #loop through the order's items and check the quantity vs the available amount.
    #if the amount available is greater than the amount ordered, inventory_tester stays true.
    #if the amount if less than available, the inventory_tester changes to false.
    order_items.each do |item|
      if item.source.on_hand >= item.quantity
        puts "#{item.source.name} is good to go."
      else
        errors[:base] << "#{item.source.name} does not have enough available inventory. Only #{item.source.on_hand} left."
        item.update(quantity: item.source.on_hand)
      end
    end

    return false if errors.present?

    #if the inventory_tester is true for all the order items, then loop through the items one more again
    #to adjust the amount available and the amount on hand.
    #
    #if there was an item that was short, dont update the order items yet.

    order_items.each do |item|
      item.source.on_hand -= item.quantity
      item.source.save
    end

    order_total = order_items.to_a.sum{|x| x.source.price * x.quantity}
    payment = Payment.find_or_initialize_by(credit_card: user.credit_card)
    payment.amount = order_total
    payment.state = Payment::COMPLETED
    payment.save

    self.payment = payment
    
    if payment.persisted?
      puts "Payment state is :  #{payment.state}"
    else
      return errors[:base] << "Payment failed"
    end

    # TODO
    # order.delete??
  end

  def serializable_hash(options={})
    {
      product_count: order_items.where(source_type: Product.name).sum(:quantity),
      order_items: order_items.map(&:serializable_hash)
    }.merge(super(options))
  end

end

