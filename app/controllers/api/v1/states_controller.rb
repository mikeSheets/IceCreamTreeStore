class Api::V1::StatesController < ApplicationController

  def index
    render json: State.all
  end
end