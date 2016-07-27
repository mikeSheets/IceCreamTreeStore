module Admin
  class ProductsController < AdminController
    load_resource find_by: :permalink
    authorize_resource

    def index
    end

    def show
    end

    def new
      @images = Dir.glob("app/assets/images/products/*.jpg")
    end

    def edit
      @images = Dir.glob("app/assets/images/products/*.jpg")
    end

    def create
      @product = Product.new(product_params)
      respond_to do |format|
        if @product.save
          format.html { redirect_to admin_products_url, notice: 'Product was successfully created.' }
          format.json { render :show, status: :created, location: @product }
        else
          format.html { render :new }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    def update
      respond_to do |format|
        if @product.update(product_params)
          format.html { redirect_to admin_products_url, notice: 'Product was successfully updated.' }
          format.json { render :show, status: :ok, location: @product }
        else
          format.html { render :edit }
          format.json { render json: @product.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      @product.destroy
      respond_to do |format|
        format.html { redirect_to admin_products_url, notice: 'Product was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :permalink, :on_hand, :available, :price, :description, :image)
    end
  end
end