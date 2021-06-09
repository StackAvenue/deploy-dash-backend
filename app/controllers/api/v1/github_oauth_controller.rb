class Api::V1::GithubOauthController < Api::V1::ResponseController
  def authorise_user
    code = params['code']
    user = User.register_oauth_user(User::OAUTH_TYPES[:github], { code: code })
    render_unauthorized(message: user[:message]) && return unless user[:success]
    
    render_success(data: user[:data])
  end
end
