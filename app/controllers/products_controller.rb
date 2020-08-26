# Controller for Products presented in ecommerce web app
class ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  # GET /products
  def index
    @products = Product.with_attached_images.limit(10).offset(params[:offset])

    images_url_array = []
    @products.each do |product|
      single_products_images = []
      product.images.each do |image|
        single_products_images.push(url_for(image))
      end
      images_url_array.push(single_products_images)
    end

    final_products = []
    @products.each do |product|
      temp_product = {}
      temp_product[:product] = product
      # temp_array = []
      # temp_array.push(images_url_array.pop)
      temp_product[:images_urls] = images_url_array.slice!(0)
      final_products.push(temp_product)
    end

    render json: final_products
  end

  # GET /products/1
  def show
    render json: @product, include: {
      images_blobs: {}
    }
  end

  # images_blobs: { only: %i[id key filename content_type created_at] }
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

  # GET /productcount
  def count
    pc = Product.count
    render json: { count: pc }
  end

  # # GET /get_images
  # def get_images
  #   @product = Product.find(params[:id])

  #   images_url_array = []
  #   @product.images.each do |image|
  #     images_url_array.push(url_for(image))
  #   end

  #   render json: images_url_array
  # end

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
