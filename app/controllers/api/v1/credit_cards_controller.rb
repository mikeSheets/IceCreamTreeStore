class Api::V1::CreditCardsController < Api::V1::BaseController

  protected
  def credit_card_params
    params.require(:credit_card).permit(:last_four, :month, :year, :user_id, :name, :number, :cvc)
  end
end