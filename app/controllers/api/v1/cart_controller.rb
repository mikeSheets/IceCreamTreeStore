class Api::V1::CartController < ApplicationController

  def add_product
    product = OrderItem.find_or_initialize_by(:source_id, :order_id)
    if product.quantity == 0
      product.delete
    else
      unless product.save
        flash[:alert] = product.errors.map{|name, err| "#{name}: #{err}"}.join(", ")
      end
    render json: product.to_json
    end
  end
end