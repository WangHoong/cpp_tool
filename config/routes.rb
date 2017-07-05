Rails.application.routes.draw do

  namespace :api do
    namespace :internal do
      resources :tasks, only: [:index]
    end
    namespace :v1 do
          namespace :cp do
            resources :contracts do
              collection do
                post :accept
              end
              member do
                post :reject
              end
              resources :authorizes,  except: [:create,:update]
            end #contracts
            resources :settlements, only: [:index] do
              member do
                put :confirm,:payment
              end
            end #settlements
          end

          resources :revenues do
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
              post :accept
            end
            member do
              post :reject
            end
            resources :copyrights, only: [:index]
          end#providers
          resources :roles do
            collection do
              get :permissions
            end
            resources :permissions, only: [:index]
          end #roles
          resources :departments, only: [:index]
          resources :authorized_ranges, only: [:index]
          resources :dsps, only: [:index, :create, :show, :update, :destroy]
          resources :banks, only: [:index, :create, :show, :update, :destroy]
          resources :tasks, only: [:create]

          resources :tracks, only: [:index, :create, :show, :update, :destroy] do
            collection do
              post :accept
              get :export
            end
            member do
              get :albums
              post :reject
            end
          end
          resources :albums, only: [:index, :create, :show, :update, :destroy] do
            collection do
              post :accept
              get :export, :query
            end
            member do
              get :materials, :tracks
              post :reject
            end
          end
          resources :videos, only: [:index, :create, :show, :update, :destroy] do
            collection do
              post :accept
              get :query, :export
            end
            member do
              get :tracks, :albums, :materials
              post :reject
            end
          end
          resources :artists, only: [:index, :create, :show, :update, :destroy] do
            collection do
              get :export
        			post :accept
        		end
            member do
              get :albums,:tracks,:multis
              post :reject
            end
          end #artists
          resources :countries, only: [:index]
          resources :currencies, only: [:index]
          resources :exchange_rates, only: [:index, :create, :show, :update, :destroy]#exchange_rates
          resources :revenues
          resources :constants, only: [] do
            collection do
              get :genres,:languages,:album_types,:artist_types
            end
          end# constants

     get "inbox_messages/unread", to: "home#inbox_messages"
    end #api
  end #v1
end
