class Api::V1::UsersController < ApplicationController
  # skip_before_action :authenticate_request, only: %i[create]
  before_action :set_user, only: %i[ show update destroy ]
  wrap_parameters :user, include: %i[username password email]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  def login
    @user = User.find_by(email: params[:email].downcase)
    if @user
      if @user.authenticate(params[:password])
        render json: @user, status: :ok
      else
        render json: "Invalid email or password", status: :unauthorized
      end
    else
      render json: "Unregistered account", status: :unauthorized
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
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

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
