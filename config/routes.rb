Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :authors do
        get :books, controller: 'author_books'
      end
      resources :books
      get 'lookup_isbn/:isbn', to: 'lookup#isbn', as: 'lookup_isbn'
    end
  end

  post 'signup', controller: :signup, action: :create
  post 'signin', controller: :signin, action: :create
  post 'refresh', controller: :refresh, action: :create
end
