# Controller for Orders of Products from Users in the web app
class OrdersController < ApiController
  before_action :set_order, only: %i[show update destroy]

  # GET /orders
  def index
    @orders = Order.all

    render json: @orders, include: { products: {
      only: %i[id title price]
    } }
  end

  # GET /orders/1
  def show
    render json: @order, include: { products: {
      only: %i[id title price]
    } }
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    params['products'].each do |product|
      @order.order_products.build(
        product_id: product[:id],
        order_id: @order.id,
        price: product[:price],
        quantity: product[:quantity].nil? ? 1 : product[:quantity]
      )
    end

    if @order.save!
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def order_params
    params.require(:order).permit(:status, :price, :gst, :pst, :hst, :user_id, :stripe_id, :products)
  end
end
