class Api::V1::AddressController < ApplicationController

  def get_states
    states = State.all
    render json: states.to_json
  end

end