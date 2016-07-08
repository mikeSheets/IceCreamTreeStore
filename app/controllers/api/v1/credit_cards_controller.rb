class Api::V1::CreditCardsController < ApplicationController

  def create
    authorize! :billing, :checkout

    cc = CreditCard.new(cc_params)
    cc.user_id = current_user.id
    if cc.save
      render json: cc.to_json
    else
      render json: cc.errors.to_json, status: 400
    end
  end

  def update
    cc = CreditCard.find(params[:id])
    if cc.update(cc_params)
      render json: cc.to_json
    else
      render json: cc.errors.to_json, status: 400
    end

  end

  protected

  def cc_params
    params.require(:credit_card).permit(:last_four, :month, :year, :user, :name, :number, :cvc)
  end

end