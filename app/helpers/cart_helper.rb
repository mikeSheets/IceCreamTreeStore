module CartHelper

  def cart
    id = session[:cart_id]
    if id
      order = Order.where(id: id, state: Order::CART).take
    elsif user_signed_in?
      order = user.orders.where(state: Order::CART).take
    end

    if order
      order.update(user_id: current_user.id) if !order.user_id and user_signed_in?
    else
      order = Order.create(user_id: current_user.try(:id))
    end

    session[:cart_id] = order.id

    order
  end
end
