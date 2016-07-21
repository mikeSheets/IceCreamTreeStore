class Api::V1::OrderItemsController < ApplicationController
  load_and_authorize_resource

  def create
    @order_item = OrderItem.find_or_initialize_by(source_id: params[:source_id], order_id: cart.id, source_type: params[:source_type])
    @order_item.quantity = params[:quantity]

    if @order_item.quantity == 0
      @order_item.save
      @order_item.delete
    else
      unless @order_item.save
        flash[:alert] = @order_item.errors.map{|name, err| "#{name}: #{err}"}.join(", ")
      end
    end
    render json: @order_item.to_json
  end

  protected
  def order_item_params
    params.require(:order_item).permit(:id, :source_id, :source_type, :order_id, :quantity)
  end
end