Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :authors do
        get :books, controller: 'author_books'
      end
      resources :books
    end
  end

  post 'signup', controller: :signup, action: :create
  post 'signin', controller: :signin, action: :create
end
