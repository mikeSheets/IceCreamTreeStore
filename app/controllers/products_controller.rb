class ProductsController < ApplicationController
  layout "application"
  before_action :set_product, only: [:show]

  def index
    @products = Product.where(available: true)
  end

  def show
    @product ||= Product.find_by_id(params[:id])
  end

  private
    def set_product
      @product = Product.find_by_permalink(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :permalink, :on_hand, :available, :price, :description, :image)
    end
end
