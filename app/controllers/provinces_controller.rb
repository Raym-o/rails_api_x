# Controller for Provinces and territories of Canada, represented in the web app
class ProvincesController < ApplicationController
  before_action :set_province, only: %i[show update destroy]

  # GET /provinces
  def index
    @provinces = Province.all

    render json: @provinces
  end

  # GET /provinces/1
  def show
    render json: @province
  end

  # POST /provinces
  # def create
  #   @province = Province.new(province_params)

  #   if @province.save
  #     render json: @province, status: :created, location: @province
  #   else
  #     render json: @province.errors, status: :unprocessable_entity
  #   end
  # end

  # PATCH/PUT /provinces/1
  def update
    if @province.update(province_params)
      render json: @province
    else
      render json: @province.errors, status: :unprocessable_entity
    end
  end

  # DELETE /provinces/1
  # def destroy
  #   @province.destroy
  # end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_province
    @province = Province.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def province_params
    params.require(:province).permit(:name, :abbr, :pst_rate, :hst_rate)
  end
end
