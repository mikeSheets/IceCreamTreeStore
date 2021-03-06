class Api::V1::OrdersController < ApplicationController
  load_and_authorize_resource
  wrap_parameters include: Order.column_names + [:credit_card_id]

  rescue_from CanCan::AccessDenied do |exception|
    if user_signed_in?
      render json: {
        message: ["permission denied"]
      }, status: 302
    else
      render json: {
          message: ["Not logged in"]
      }, status: 303
    end
  end

  def get_cart
    if cart
      render json: cart.to_json
    else
      render json: {}, status: 404
    end
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
    params.require(:order).permit(:user_id, :address_id, :state, :credit_card_id)
  end
end