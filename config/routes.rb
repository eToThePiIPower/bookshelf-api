Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :authors
      resources :books
    end
  end

  post 'signup', controller: :signup, action: :create
end
