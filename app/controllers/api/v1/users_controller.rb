class Api::V1::UsersController < Api::V1::ResponseController
  def show
    user_details = User.get_user_details(params['access_token'])
    render_error(message: user_details[:message]) && return unless user_details[:success]

    render_success(data: user_details[:data])
  end
end
