module CartHelper

  def cart
    id = session[:cart_id]
    if id
      order = Order.where(id: id, state: Order::CART).take
    elsif user_signed_in?
      order = current_user.orders.where(state: Order::CART).take
    end

    if order
      order.update(user_id: current_user.id) if !order.user_id and user_signed_in?
      session[:cart_id] = order.id
    end
    order
  end

  def create_cart
    order = Order.create(user_id: current_user.try(:id))
    session[:cart_id] = order.id if order
    order
  end
end
