class Github
  def self.get_basic_user_details(oauth_data)
    code = oauth_data[:code]
    # return Response.error('No code available!') if oauth_data[:code].blank?
    access_token = get_access_token(code)
    # return access_token unless access_token[:success]
    # access_token = access_token[:data][:access_token
    user_details = get_user_details(access_token)
    user_details = user_details.slice("login","id","avatar_url", "url", "organisations_url", "received_events_url", "name", "company", "blog", "location", "email", "bio", "created_at", "twitter_username")
    return {user_details: user_details, access_token: "#{access_token}"}
  # rescue StandardError => e
  #   return Response.error(500, 'NetworkReach', e.message)
  end

  def self.get_access_token(code)
    url = "https://github.com/login/oauth/access_token"
    response = RestClient::Request.execute(method: :post, url: url, headers: { params: {client_id: "#{ENV['CLIENT_ID']}", client_secret: "#{ENV['CLIENT_SECRET']}", code: "#{code}"}, Accept: 'application/json' })
    access_token = JSON.parse(response.body)
    access_token = access_token["access_token"]
    return access_token
  end

  def self.get_user_details(access_token)
    url = 'https://api.github.com/user'
    response = RestClient::Request.execute(method: :get, url: url, headers: { Authorization: "token #{access_token}"})
    user_details = JSON.parse(response.body)
    return user_details
  end
end
