class CreditCardController < ApplicationController
  layout "application"
  def index
  end

  def cc_params
    params.require(:credit_card).permit(:last_four, :month, :year, :user, :name, :number, :cvc)
  end
end