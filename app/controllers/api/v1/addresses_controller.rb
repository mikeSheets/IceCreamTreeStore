class Api::V1::AddressesController < Api::V1::BaseController

  protected
  def address_params
    params.require(:address).permit(:name, :line1, :line2, :city, :state_id, :zip, :user_id)
  end
end