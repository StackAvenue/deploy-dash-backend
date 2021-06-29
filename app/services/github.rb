class Github
  def self.get_basic_user_details(oauth_data)
    code = oauth_data[:code]
    return { success: false, message: 'No code available!' } if oauth_data[:code].blank?

    access_data = get_access_token(code)
    return { success: access_data[:success], message: access_data[:error] } unless access_data[:success]

    user_details = get_user_details(access_data)
    repos_url = get_repo_url(user_details)
    repos = repositories(repos_url)
    user_details = user_details.slice(
      'login', 'id', 'avatar_url', 'url', 'organisations_url', 'received_events_url', 'name',
      'company', 'blog', 'location', 'email', 'bio', 'created_at', 'twitter_username'
    )
    {
      success: true, user_details: user_details, repos_url: repos_url,
      repositories: repos, access_token: access_data[:access_token]
    }
  end

  def self.get_access_token(code)
    url = ENV['GIT_OAUTH_LOGIN_URL']
    response = RestClient::Request.execute(
      method: :post,
      url: url,
      headers: {
        params:
        {
          client_id: "#{ENV['CLIENT_ID']}",
          client_secret: "#{ENV['CLIENT_SECRET']}",
          code: "#{code}"
        },
        Accept: 'application/json'
      }
    )
    json_response = JSON.parse(response.body)
    access_token = json_response['access_token']
    return { success: true, access_token: access_token } unless access_token.nil?

    { success: false, error: json_response['error_description'] }
  end

  def self.get_repo_url(user_details)
    url = user_details['url']
    response = RestClient::Request.execute(
      method: :get,
      url: url
    )
    user = JSON.parse(response.body)
    user['repos_url']
  end

  def self.get_user_details(access_data)
    url = ENV['GIT_USER_DETAILS_URL']
    response = RestClient::Request.execute(
      method: :get,
      url: url,
      headers: { Authorization: "token #{access_data[:access_token]}" }
    )
    JSON.parse(response.body)
  end

  def self.repositories(repos_url)
    response = RestClient::Request.execute(
      method: :get,
      url: repos_url
    )
    repositories = JSON.parse(response.body)
    repo_array = []
    repositories.each do |repo|
      name = repo['name']
      full_name = repo['full_name']
      branches = repo['branches_url']
      hash = { name: name, full_name: full_name, branches_url: branches }
      repo_array << hash
    end
    repo_array
  end

  def self.branches(branches_url)
    response = RestClient::Request.execute(
      method: :get,
      url: branches_url
    )
    branches = JSON.parse(response.body)
    branches_array = []
    branches.each do |branch|
      name = branch['name']
      hash = { name: name }
      branches_array << hash
    end
    branches_array
  end
end
