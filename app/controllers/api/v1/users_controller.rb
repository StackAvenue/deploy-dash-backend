class Api::V1::UsersController < ApplicationController

  def show
    access_token = params["access_token"]
    user_details = User.get_user_details(access_token)
    render json: user_details
  end

end