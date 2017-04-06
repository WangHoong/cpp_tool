Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
          resources :sessions, only: [:create]
          resources :users, only: [:index, :create, :show, :update, :destroy]  do
            collection do
              get :current
            end
          end
          resources :roles, only: [:index, :create, :show, :update, :destroy]
          resources :tracks, only: [:index, :create, :show, :update, :destroy]
          resources :albums, only: [:index, :create, :show, :update, :destroy]
          resources :artists, only: [:index, :create, :show, :update, :destroy]

    end #api
  end #v1
end
