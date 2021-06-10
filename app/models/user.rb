class User < ApplicationRecord
  serialize :repositories, Array
  validates_uniqueness_of :login, :git_id

  OAUTH_TYPES = {
    github: :github
  }.freeze
  OAUTH_SERVICE_NAME = {
    github: 'Github'
  }.freeze
  class << self
    def register_oauth_user(oauth_service_name, oauth_data)
      user_details = OAUTH_SERVICE_NAME[oauth_service_name].constantize.get_basic_user_details(oauth_data)
      return user_details unless user_details[:success]
      return User.update_details(access_token: user_details[:access_token]) if User.exists(user_details)[:success]

      User.create_user(user_details)
    end

    def get_user_details(access_token)
      user_details = User.where(access_token: access_token)
      return { success: false, message: 'Invalid or empty access token!!' } if user_details.first.nil?

      user_details = { user: User.to_json(user_details) }
      { success: true, data: user_details }
    end

    def get_repositories(oauth_service_name, access_token)
      user = get_user_details(access_token)
      return user unless user[:success]

      repos_url = user[:data][:user]['repos_url']
      repositories = OAUTH_SERVICE_NAME[oauth_service_name].constantize.repositories(repos_url)
      repo_names = []
      repositories.each do |repo|
        name = repo[:name]
        full_name = repo[:full_name]
        hash = { name: name, full_name: full_name }
        repo_names << hash
      end
      repositories_names = { repositories: repo_names }
      { success: true, data: repositories_names }
    end

    def create_user(user_details)
      user = User.create(
        access_token: user_details[:access_token],
        login: user_details[:user_details]['login'],
        git_id: user_details[:user_details]['id'],
        avatar_url: user_details[:user_details]['avatar_url'],
        url: user_details[:user_details]['url'],
        repos_url: user_details[:repos_url],
        repositories: user_details[:repositories],
        organisations_url: user_details[:user_details]['organisations_url'],
        received_events_url: user_details[:user_details]['received_events_url'],
        name: user_details[:user_details]['name'],
        company: user_details[:user_details]['company'],
        blog: user_details[:user_details]['blog'],
        location: user_details[:user_details]['location'],
        email: user_details[:user_details]['email'],
        bio: user_details[:user_details]['bio'],
        github_account_created_at: user_details[:user_details]['created_at'],
        twitter_username: user_details[:user_details]['twitter_username']
      )
      user = { user: user }
      { data: user, success: true }
    end

    def exists(user_details)
      user =  User.where(git_id: user_details[:user_details]['id'], login: user_details[:user_details]['login'])
      return { success: true } if user.present?

      { success: false }
    end

    def update_details(access_token)
      user = User.update(access_token: access_token[:access_token])
      user = { user: User.to_json(user) }
      { data: user, success: true }
    end

    def to_json(user)
      user.as_json.first
    end
  end
end
