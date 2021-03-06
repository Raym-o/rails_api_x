require 'bcrypt'

# Controller for class representing users of web app.
class UsersController < ApiController
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    @users = User.includes(:address, :orders).all

    render json: @users, include: {
      address: {
        only: %i[line_1 line_2 city postal_code province_id]
      },
      orders: {
      }
    }
  end

  # GET /users/1
  def show
    render json: @user, include: {
      address: {},
      orders: {}
    }
  end

  def authenticate
    @user = User.find_by(username: params[:username])
                .try(:authenticate, params[:password])

    if @user.nil?
      render json: {}, status: :not_found
    else
      render json: @user, include: {
        address: {},
        orders: {}
      }
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.password = params[:password]

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def updateaddress
    @user = User.find(user_params[:id])
    new_address = Address.new(
      line_1: params[:address][:line_1],
      line_2: params[:address][:line_2],
      city: params[:address][:city],
      postal_code: params[:address][:postal_code],
      province_id: params[:address][:province_id]
    )
    @user.address = new_address
    if @user.save
      render json: @user, include: { address: {} }, status: :accepted, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.require(:user).permit(:id, :f_name, :l_name, :username, :email, :password)
  end
end
