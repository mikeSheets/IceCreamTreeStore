class Api::V1::CreditCardsController < ApplicationController

  def create
    authorize! :billing, :checkout

    cc = current_user.credit_card || CreditCard.new(name: current_user.name)

    if cc.save
      render json: cc.to_json
    else
      # TODO
    end
  end

  def update
    cc = CreditCard.find(params[:id])
    if cc.update(cc_params)
      render json: cc.to_json
    else
      # TODO
    end

  end

  protected

  def cc_params
    params.require(:credit_card).permit(:last_four, :month, :year, :user, :name, :number, :cvc)
  end

end