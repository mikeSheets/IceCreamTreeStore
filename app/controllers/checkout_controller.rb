class CheckoutController < ApplicationController

  def index
  end

  def address
    @address = current_user.address || Address.new(name: current_user.name)
  end

  def billing
    @credit_card = current_user.credit_card || CreditCard.new(name: current_user.name)
  end
end
