class ArtistsController < ApplicationController
  # Get /artists
  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @artists = Artist.recent.page(page).per(size)
    render json: @artists, meta: meta_attributes(@artists)
  end

  # Get /artists/:id
  def show
    @artist = get_artist
    render json: @artist
  end

  # Put /artists/:id
  def update
    if @artist = get_artist.update_attributes(artist_params)
    render json: @artist
    else
    render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # Post /artists
  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # Delete /artists/:id
  def destroy
    if @artist = get_artist.update_attributes(status: :disabled)
    render json: @artist
    else
    render json: @artist.errors, status: :unprocessable_entity
    end
  end



  private
  def get_artist
    Artist.includes(:country).find(params[:id])
  end

  def artist_params
    params
        .require(:artist)
        .permit(
            :name,
            :country_id,
            :country_name,
            :gender_type,
            :biography,
            :label_id,
            :label_name
        )
  end
end
