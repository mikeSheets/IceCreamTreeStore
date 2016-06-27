class CheckoutController < ApplicationController
  def index
  end




  # Entering and editing Addresses

  def address
    authorize! :address, :cart

    @address = current_user.address || Address.new(name: current_user.name)
  end

  def add_address
    @address = Address.new(address_params)
    @address.user = current_user

    if @address.save
      redirect_to cart_billing_url
    else
      render 'address'
    end
  end

  def edit_address
    @address = Address.find(params[:id])

    if @address.update(address_params)
      redirect_to cart_billing_url
    else
      render 'address'
    end
  end




  # Entering billing information

  def billing
    authorize! :billing, :cart

    authorize! :billing, :cart

    @credit_card = current_user.credit_card || CreditCard.new(name: current_user.name)
  end

  def add_cc
    @credit_card = CreditCard.new(cc_params)
    @credit_card.user = current_user

    if @credit_card.save
      redirect_to cart_checkout_url
    else
      render 'billing'
    end
  end

  def edit_cc
    @credit_card = CreditCard.find(params[:id])

    if @credit_card.update(cc_params)
      redirect_to cart_checkout_url
    else
      render 'billing'
    end
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





  # Adding and removing product from cart

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





  # params

  def address_params
    params.require(:address).permit(:name, :line1, :line2, :city, :state_id, :zip)
  end

  def cc_params
    params.require(:credit_card).permit(:last_four, :month, :year, :user, :name, :number, :cvc)
  end
end
