class Api::V1::ProductsController < ApplicationController

  def add_product
    product = OrderItem.find_or_initialize_by(:source_id, :order_id)

    if :quantity == 0
      puts product
      product.delete
      puts product
    else
      unless product.save
      flash[:alert] = product.errors.map{|name, err| "#{name}: #{err}"}.join(", ")
      end
    end
    render json: product.to_json
  end
end