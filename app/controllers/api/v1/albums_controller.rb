class Api::V1::AlbumsController < Api::V1::BaseController
  # Get /albums
  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @artists = Artist.recent.page(page).per(size)
    render json: @artists, meta: page_info(@artists)
  end

  # Post /albums
  def create
    puts params
    render json: params[:bbb]
  end

  private
  def album_params
    params
        .require(:album)
        .permit(
            :name,
            :artist_id,
            :language,
            :genre,
            :format,
            :label_id,
            :label_name
        )
  end
end
