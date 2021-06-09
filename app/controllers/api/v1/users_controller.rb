class Api::V1::UsersController < Api::V1::ResponseController
  def show
    access_token = params['access_token']
    user_details = User.get_user_details(access_token)
    render_error(message: user_details[:message]) && return unless user_details[:success]

    render_success(data: user_details[:data])
  end
end
