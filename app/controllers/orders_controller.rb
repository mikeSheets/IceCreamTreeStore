class OrdersController < ApplicationController
  layout "application"

  def index
    @orders = Order.where("state = placed AND user = current_user", state, user)

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