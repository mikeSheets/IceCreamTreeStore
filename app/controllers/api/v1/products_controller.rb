class Api::V1::ProductsController < ApplicationController

  def add_product
    product = OrderItem.find_or_initialize_by(:source_id, :order_id)
    unless product.save
      flash[:alert] = product.errors.map{|name, err| "#{name}: #{err}"}.join(", ")
    end

    render json: product.to_json
  end
end