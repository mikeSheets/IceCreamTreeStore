class Api::V1::ProductsController < ApplicationController

  def add_product
    oi = OrderItem.find_or_initialize_by(source_id: params[:product_id], source_type: Product.name, order_id: cart.id)
    oi.quantity = params[:quantity]

    puts "#{params[:product_id]} should be set to #{params[:quantity]}"
    puts oi.inspect

    if oi.save

    else
      flash[:alert] = oi.errors.map{|name, err| "#{name}: #{err}"}.join(", ")
    end
  end
end