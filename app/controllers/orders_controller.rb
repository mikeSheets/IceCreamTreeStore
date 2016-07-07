class OrdersController < ApplicationController
  layout "application"
  def index
  end
  def show
    @order = Order.find(params[:id])
    @credit = @order.payment.credit_card
  end

  protected

  def order_params
    params.require(:order).permit(:user, :address, :state, :id, :payment)
  end
end