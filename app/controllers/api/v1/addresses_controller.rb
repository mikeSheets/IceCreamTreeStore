class Api::V1::AddressesController < ApplicationController

  def create
    authorize! :address, :checkout

    address = current_user.address || Address.new(name: current_user.name)

    if address.save
      render json: address.to_json
    else
      # TODO
    end
  end

  def update
    address = Address.find(params[:id])
    if address.update(address_params)
      render json: address.to_json
    else
      # TODO
    end

  end

  protected

  def address_params
    params.require(:address).permit(:name, :line1, :line2, :city, :state_id, :zip, :user)
  end

end