class Github
  def self.get_basic_user_details(oauth_data)
    code = oauth_data[:code]
    return { success: false, message: 'No code available!' } if oauth_data[:code].blank?

    access_data = get_access_token(code)
    return { success: access_data[:success], message: access_data[:error] } unless access_data[:success]

    user_details = get_user_details(access_data)
    user_details = user_details.slice(
      'login', 'id', 'avatar_url', 'url', 'organisations_url', 'received_events_url', 'name',
      'company', 'blog', 'location', 'email', 'bio', 'created_at', 'twitter_username'
    )
    { success: true, user_details: user_details, access_token: access_data[:access_token] }
  end

  def self.get_access_token(code)
    url = 'https://github.com/login/oauth/access_token'
    response = RestClient::Request.execute(method: :post, url: url, headers: { params: {client_id: "#{ENV['CLIENT_ID']}", client_secret: "#{ENV['CLIENT_SECRET']}", code: "#{code}"}, Accept: 'application/json' })
    json_response = JSON.parse(response.body)
    access_token = json_response['access_token']
    return { success: true, access_token: access_token } unless access_token.nil?

    { success: false, error: json_response['error_description'] }
  end

  def self.get_user_details(access_data)
    url = 'https://api.github.com/user'
    response = RestClient::Request.execute(
      method: :get,
      url: url,
      headers: { Authorization: "token #{access_data[:access_token]}" }
    )
    JSON.parse(response.body)
  end
end
