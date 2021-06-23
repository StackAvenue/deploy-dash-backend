# frozen_string_literal: false

# this is users controller
class Api::V1::UsersController < Api::V1::ResponseController
  def show
    user_details = User.get_user_details(@access_token)
    render_unauthorized(message: user_details[:message]) && return unless user_details[:success]

    render_success(data: user_details[:data])
  end

  def repositories
    repositories = User.get_repositories(User::OAUTH_TYPES[:github], @access_token)
    render_unauthorized(message: repositories[:message]) && return unless repositories[:success]

    render_success(data: repositories[:data])
  end

  def branches
    branch_name = params['full_name']
    branches = User.get_branches(User::OAUTH_TYPES[:github], @access_token, branch_name)
    return render_unauthorized(message: branches[:message]) if branches[:message] == 'Invalid access token!!'

    return render_error(message: branches[:message]) if branches[:message] == 'Invalid or empty branch name'

    render_success(data: branches[:data])
  end
end
