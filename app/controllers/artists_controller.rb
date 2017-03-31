class ArtistsController < ApplicationController
  # Get /artists
  def index
    @artists = Artist.recent
    render json: @artists
  end
end
