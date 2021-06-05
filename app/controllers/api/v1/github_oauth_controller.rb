class Api::V1::GithubOauthController < ApplicationController

  def authorise_user
    code = params["code"]
    user = User.register_oauth_user(User::OAUTH_TYPES[:github], { code: code })
    render json: user
  end
  
end
