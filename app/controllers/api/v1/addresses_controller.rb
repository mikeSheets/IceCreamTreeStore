class Api::V1::AddressesController < ApplicationController
  load_and_authorize_resource :address

  def create
    address = Address.new(address_params)
    address.user_id = current_user.id

    if address.save
      render json: address.to_json
    else
      render json: address.errors.to_json, status: 400
    end
  end

  def update
    address = Address.find(params[:id])
    if address.update(address_params)
      render json: address.to_json
    else
      render json: address.errors.to_json, status: 400
    end
  end

  protected
  def address_params
    params.require(:address).permit(:name, :line1, :line2, :city, :state_id, :zip, :user)
  end
end