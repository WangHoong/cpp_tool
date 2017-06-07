class Api::Internal::AlbumsController < ApplicationController
  # Get /albums
  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    @albums = Album.recent.page(page).per(size)
    render json: @albums, meta: page_info(@albums)
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
            :not_through_reason,
            :status,
            :remark,
            :release_version,
            primary_artist_ids: [],
            featuring_artist_ids: [],
            songs_attributes: [:id, :url, :native_name, :_destroy],
            images_attributes: [:id, :url, :native_name, :_destroy]
        )
  end
end
