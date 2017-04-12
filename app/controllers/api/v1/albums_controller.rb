class Api::V1::AlbumsController < Api::V1::BaseController
  # Get /albums
  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    @albums = Album.recent.page(page).per(size)
    render json: @albums, meta: page_info(@albums)
  end

  # Get /albums/:id
  def show
    render json:  get_album
  end

  # Put /albums/:id
  def update
    if @albums = get_album.update(album_params)
    render json: @albums
    else
    render json: @albums.errors, status: :unprocessable_entity
    end
  end

  # Post /albums
  def create
    puts album_params.to_h
    @album = Album.new(album_params)
    if @album.save
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
    end
  end

  # Delete /albums/:id
  def destroy
    if @artist = get_album.update_attributes(status: :disabled)
    render json: @artist
    else
    render json: @artist.errors, status: :unprocessable_entity
    end
  end

  private
  def get_album
    Album.find(params[:id])
  end
  def album_params
    params
        .require(:album)
        .permit(
            :name,
            :language_id,
            :genre,
            :format,
            :label_id,
            primary_artists_attributes: [:name],
            primary_artist_ids: [],
            featuring_artist_ids: []
        )
  end
end
