class Api::V1::UsersController < Api::V1::ResponseController
  def show
    access_token = params['access_token']
    user_details = User.get_user_details(access_token)
    render_error(message: user_details[:message]) && return unless user_details[:success]

    render_success(data: user_details[:data])
  end

  def repositories
    access_token = params['access_token']
    repositories = User.get_repositories(User::OAUTH_TYPES[:github], access_token)
    render_error(message: repositories[:message]) && return unless repositories[:success]

    render_success(data: repositories[:data])
  end
end
