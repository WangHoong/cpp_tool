Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
          namespace :cp do
            resources :contracts do
              collection do
                post :unverify,:verify
              end
              resources :authorizes,  except: [:create,:update]
            end
          end #contracts
          resources :sessions, only: [:create]
          resources :users, only: [:index, :create, :show, :update, :destroy]  do
            collection do
              get :current
            end
          end #users
          resources :dsps, only: [:index, :create, :show, :update, :destroy]
          resources :providers, only: [:index, :create, :show, :update, :destroy] do
            collection do
              post :unverify,:verify
            end
          end#providers
          resources :roles, only: [:index, :create, :show, :update, :destroy] do
            collection do
              get :permissions
            end
            resources :permissions, only: [:index]
          end #roles
          resources :tracks, only: [:index, :create, :show, :update, :destroy]
          resources :albums, only: [:index, :create, :show, :update, :destroy]
          resources :artists, only: [:index, :create, :show, :update, :destroy] do
            collection do
        			post :approve
        		end
          end #artists

          resources :reports
          resources :constants, only: [] do
            collection do
              get :genres
              get :album_types
              get :artist_types
            end
          end# constants

    end #api
  end #v1
end
