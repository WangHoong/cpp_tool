Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
          namespace :cp do
            resources :contracts do
              collection do
                post :unverify,:verify
              end
              resources :authorizes,  except: [:create,:update]
            end #contracts
            resources :settlements
          end

          resources :reports do
            member do
              get :analyses_file
              put :processed
              put :confirm
              put :account
              put :done
              put :reprocess
            end
          end

          resources :authorized_areas
          resources :sessions, only: [:create]
          resources :sts, only: [] do
            collection do
              get :media_token,:ro_token
            end
          end
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
          resources :roles do
            collection do
              get :permissions
            end
            resources :permissions, only: [:index]
          end #roles
          resources :banks, only: [:index, :create, :show, :update, :destroy]
          resources :tracks, only: [:index, :create, :show, :update, :destroy]
          resources :albums, only: [:index, :create, :show, :update, :destroy] do
            collection do
              post :approve
            end
          end
          resources :artists, only: [:index, :create, :show, :update, :destroy] do
            collection do
        			post :approve
        		end
            member do
              post :approve
            end
          end #artists
          resources :countries, only: [:index]
          resources :currencies, only: [:index]
          resources :exchange_rates, only: [:index, :create, :show, :update, :destroy]#exchange_rates
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
