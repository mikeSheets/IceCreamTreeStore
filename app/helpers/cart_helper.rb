module CartHelper

  def cart
    id = session[:cart_id]
    if id
      order = Order.where(id: id, state: Order::CART).take
    elsif user_signed_in?
      order = user.orders.where(state: Order::CART).take
    end

    unless order
      order = Order.create(user_id: current_user.try(:id))
    end

    session[:cart_id] = order.id

    order
  end
end
