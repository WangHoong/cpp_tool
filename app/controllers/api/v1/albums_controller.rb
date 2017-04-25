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
    render json: get_album
  end

  # Put /albums/:id
  def update
    @albums = get_album
    if @albums.update(album_params)
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
    @album = get_album
    if @album.destroy
    render json: @album
    else
    render json: @album.errors, status: :unprocessable_entity
    end
  end

  # Post /albums/approve
  def approve
    @albums = get_albums_by_ids
    @albums.update(status: :agree)
    render json: @albums
  end

  private
  def get_album
    Album.find(params[:id])
  end

  def get_albums_by_ids
    Album.where(id: params[:album_ids])
  end

  def album_params
    params
        .require(:album)
        .permit(
            :name,
            :language_id,
            :genre,
            :format,
            :label,
            :upc,
            :remark,
            :release_version,
            primary_artist_ids: [],
            featuring_artist_ids: [],
            songs_attributes: [:id, :url, :native_name, :_destroy],
            images_attributes: [:id, :url, :native_name, :_destroy]
        )
  end
end
