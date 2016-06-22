class Api::V1::OrdersController < ApplicationController

  def get_cart
    render json: cart.to_json
  end
end