Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :github_oauth do
        get :authorise_user, on: :collection
      end
      resources :users, only: [:show] do
        get :repositories, on: :collection
      end
    end
  end

  get '/api/v1/users', to: 'api/v1/users#show'
end
