class Api::V1::CreditCardsController < ApplicationController
  load_and_authorize_resource

  def create
    @credit_card.user_id = current_user.id

    if @credit_card.save
      render json: @credit_card.to_json
    else
      render json: @credit_card.errors.to_json, status: 400
    end
  end

  def update
    if @credit_card.update(credit_card_params)
      render json: @credit_card.to_json
    else
      render json: @credit_card.errors.to_json, status: 400
    end
  end

  protected
  def credit_card_params
    params.require(:credit_card).permit(:last_four, :month, :year, :user_id, :name, :number, :cvc)
  end
end