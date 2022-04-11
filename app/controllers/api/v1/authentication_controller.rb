class Api::V1::AuthenticationController < ApplicationController
  # skip_before_action :authenticate_request
  before_action :authenticate_request, only: %i[me]

  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      render json: "Unauthorized Access", status: :unauthorized
    end
  end

  def me
    if @current_user
      render json: @current_user
    else
      render json: "Unauthorized Access", status: :unauthorized
    end
  end
end
