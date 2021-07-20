class ApplicationController < ActionController::API
  before_action :access_token, except: [:authorise_user]

  def access_token
    access_token = request.headers['Authorization']
    return render_unauthorized(message: 'Empty Access token') if access_token.nil?

    @access_token = access_token.split(' ').last
  end
end
