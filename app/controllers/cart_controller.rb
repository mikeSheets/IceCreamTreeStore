class CartController < ApplicationController
  def index
  end

  def address
    authorize! :address, :cart
  end

  def billing
    authorize! :billing, :cart
  end

  def checkout

  end

  def cart_total

  end

  # TODO - this is a post
  def place_order
    cart.state = Order::PLACED
    cart.save
    # TODo validation and stuff
  end

  def add_product
    oi = OrderItem.find_or_initialize_by(source_id: params[:product_id], source_type: Product.name, order_id: cart.id)
    oi.quantity = params[:quantity]

    puts "#{params[:product_id]} should be set to #{params[:quantity]}"
    puts oi.inspect

    if oi.save

    else
      flash[:alert] = oi.errors.map{|name, err| "#{name}: #{err}"}.join(", ")
    end
    redirect_to cart_path
  end

  def cart_destroy
    cart.state = Order::CANCELLED
    cart.delete

    redirect_to cart_path
  end
end
