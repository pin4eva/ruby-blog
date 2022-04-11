Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "users/login", to: "users#login"
      resources :users, except: %i[login]
      post "/auth/login", to: "authentication#login"
      get "/auth/me", to: "authentication#me"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
