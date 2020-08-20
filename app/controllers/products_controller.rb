# Controller for Products presented in ecommerce web app
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  # GET /products
  def index
    @products = Product.with_attached_images.limit(10).offset(params[:offset])

    render json: @products, include: {
      images_blobs: { only: %i[id key filename content_type created_at] }
    }
  end

  # GET /products/1
  def show
    render json: @product, include: {
      images_blobs: { only: %i[id key filename content_type created_at] }
    }
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
    @product.destroy
  end

  def count
    pc = Product.count
    render json: { count: pc }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def product_params
    params.require(:product).permit(:title, :description, :price, :images)
  end
end
