class Api::V1::OrderItemsController < ApplicationController

  def create
    oi = OrderItem.find_or_initialize_by(source_id: params[:source_id], order_id: cart.id, source_type: params[:source_type])
    oi.quantity = params[:quantity]

    if oi.quantity == 0
      oi.delete
    else
      unless oi.save
        flash[:alert] = oi.errors.map{|name, err| "#{name}: #{err}"}.join(", ")
      end
    end
    render json: oi.to_json
  end

  protected
  def order_item_params
    params.require(:order_item).permit(:id, :source_id, :source_type, :order_id, :quantity)
  end
end