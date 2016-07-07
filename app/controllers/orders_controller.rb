class OrdersController < ApplicationController
  layout "application"
  def index
  end
  def show
    @order = Order.find_by(params[:id])
    @payment = @order.payment
  end

  protected

  def order_params
    params.require(:order).permit(:user, :address, :state, :id, :payment)
  end
end