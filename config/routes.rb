Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
          namespace :cp do
            resources :contracts do
              resources :authorizes,  except: [:create,:update]
            end
          end

          resources :sessions, only: [:create]
          resources :users, only: [:index, :create, :show, :update, :destroy]  do
            collection do
              get :current
            end
          end
          resources :dsps, only: [:index, :create, :show, :update, :destroy]
          resources :providers, only: [:index, :create, :show, :update, :destroy]
          resources :roles, only: [:index, :create, :show, :update, :destroy] do
            collection do
              get :permissions
            end
            resources :permissions, only: [:index]
          end
          resources :tracks, only: [:index, :create, :show, :update, :destroy]
          resources :albums, only: [:index, :create, :show, :update, :destroy]
          resources :artists, only: [:index, :create, :show, :update, :destroy] do
            collection do
        			put :approve
        		end
          end

          resources :constants, only: [] do
            collection do
              get :genres
              get :album_types
              get :artist_types
            end
          end

    end #api
  end #v1
end
