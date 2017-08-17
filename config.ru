# This file is used by Rack-based servers to start the application.
 
require_relative 'config/environment'
require 'sidekiq/web'

map '/sidekiq' do
  use Rack::Auth::Basic, "Protected Area" do |username, password|
    username == 'topdmc' && password == '123123'
  end

  run Sidekiq::Web
end

run Rails.application
