class User < ApplicationRecord

  validates_uniqueness_of :login, :git_id

  OAUTH_TYPES = {
    github: :github
  }
  
  OAUTH_SERVICE_NAME = {
    github: 'Github'
  }
  
  class << self
    def register_oauth_user(oauth_service_name, oauth_data)
      user_details = OAUTH_SERVICE_NAME[oauth_service_name].constantize.get_basic_user_details(oauth_data)
      return user = User.create_user(user_details) unless User.exists(user_details)
      return user = User.update(access_token: user_details[:access_token])
    end

    def get_user_details(access_token)
      user_details = User.where(access_token: "#{access_token}")
      user_details
    end
      
  end
  
  private 
  class << self
    def create_user(user_details)
      user = User.create(access_token: user_details[:access_token],
      login: user_details[:user_details]["login"],
      git_id: user_details[:user_details]["id"],
      avatar_url: user_details[:user_details]["avatar_url"], 
      url: user_details[:user_details]["url"], 
      organisations_url: user_details[:user_details]["organisations_url"], 
      received_events_url: user_details[:user_details]["received_events_url"], 
      name: user_details[:user_details]["name"],
      company: user_details[:user_details]["company"],
      blog: user_details[:user_details]["blog"], 
      location: user_details[:user_details]["location"], 
      email: user_details[:user_details]["email"], 
      bio: user_details[:user_details]["bio"], 
      github_account_created_at: user_details[:user_details]["created_at"], 
      twitter_username: user_details[:user_details]["twitter_username"])
    end

    def exists(user_details)
      user =  User.where(git_id: user_details[:user_details]["id"], login: user_details[:user_details]["login"] )
      return true if user.present?
    end
  end
 
end

