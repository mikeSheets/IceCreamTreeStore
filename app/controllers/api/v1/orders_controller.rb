class Api::V1::OrdersController < ApplicationController


  def get_cart
    render json: cart.to_json
  end

  def update
    order = Order.find_or_initialize_by(id: params[:id])
    if order.update(order_params)
      render json: order.to_json, status: 200
    else
      render json: order.errors.to_json, status: 400
    end

  end

  protected

  def order_params
    params.require(:order).permit(:user_id, :address_id, :state)
  end

end