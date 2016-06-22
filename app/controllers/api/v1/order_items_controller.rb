class Api::V1::OrderItemsController < ApplicationController

  def create
    oi = OrderItem.new(order_item_params)

    if !oi.save
      flash[:alert] = oi.errors.map{|name, err| "#{name}: #{err}"}.join(", ")
    end

    render json: oi.to_json

  end

  protected

  def order_item_params
    params.require(:order_item).permit(:id, :source_id, :source_type, :order_id, :quantity)
  end

end