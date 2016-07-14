class HomeController < ApplicationController
  layout "application"
  load_and_authorize_resource :address, :credit_card, :order

  def index
  end

  def account
    if user_signed_in?
    @user = User.find_by(id: current_user.id)
    @address = Address.find_by(user_id: current_user.id) || Address.new(name: current_user.name)
    @credit_card = CreditCard.find_by(user_id: current_user.id) || CreditCard.new(name: current_user.name)
    @orders = Order.where(state: "placed", user_id: current_user.id)
    else
      redirect_to new_user_session_path
    end
  end
end
