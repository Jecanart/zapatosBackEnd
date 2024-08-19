class ProductsController < ApplicationController
  before_action :set_product, only: %i[ show update destroy get_final_price update_stock update_discount ]

  # GET /products
  def index
    @products = Product.all
    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy!
    head :no_content
  end

  # GET /products/1/get_final_price
  def get_final_price
    final_price = @product.product_price - (@product.product_price * @product.discount / 100.0)
    render json: { final_price: final_price }
  end

  # PATCH/PUT /products/1/update_stock
  def update_stock
    if @product.update(stock: params[:stock])
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1/update_discount
  def update_discount
    if @product.update(discount: params[:discount])
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # GET /products/get_by_brand
  def get_by_brand
    @products = Product.where(brand: params[:brand])
    render json: @products
  end

  # GET /products/get_by_name
  def get_by_name
    @products = Product.where("product_name LIKE ?", "%#{params[:name]}%")
    render json: @products
  end

  private

    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:product_name, :product_price, :stock, :discount, :brand, :main_img)
    end
end
