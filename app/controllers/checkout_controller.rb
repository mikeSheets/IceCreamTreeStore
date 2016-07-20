class CheckoutController < ApplicationController

  def index
    @address = current_user.address || Address.new(name: current_user.name, user_id: current_user.id)
    @credit_card = current_user.credit_card || CreditCard.new(name: current_user.name, user_id: current_user.id)
  end

  def address
    @address = current_user.address || Address.new(name: current_user.name, user_id: current_user.id)
  end

  def billing
    @credit_card = current_user.credit_card || CreditCard.new(name: current_user.name, user_id: current_user.id)
  end
end
