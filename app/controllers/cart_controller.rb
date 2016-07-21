class CartController < ApplicationController
  def index
  end

  def cart_destroy
    cart.state = Order::CANCELLED
    cart.delete

    redirect_to products_path
  end
end