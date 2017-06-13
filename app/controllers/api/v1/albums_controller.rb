class Api::V1::AlbumsController < Api::V1::BaseController
  # Get /albums
  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    @albums = Album.recent.page(page).per(size)
    render json: @albums,
      each_serializer: Api::V1::Albums::IndexSerializer,
      meta: page_info(@albums)
  end

  # Get /albums/:id
  def show
    render json: get_album,
      serializer: Api::V1::Albums::ShowSerializer
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
    def approve
      case !!params[:id]
        when true
          @album = get_album
          begin
            Album.approve(album_params, @album)
            render json: @album
          rescue Workflow::NoTransitionAllowed => e
            render json: {status: 403, error: e}, status: :forbidden
          end
        else
          @albums = get_albums_by_ids
          if Album.batchApprove(@albums)
            render json: @albums
          else
            render json: @albums.errors, status: :unprocessable_entity
          end
      end
    end
  end

  # POST /albums/export
  def export
    ids = (params[:ids] || '').split(',')
    return render text: '请选择要导出的id列表' if ids.empty?

    @albums = Album.where(id: ids)
    render xlsx: 'albums/export.xlsx.axlsx', filename: '专辑列表.xlsx', xlsx_author: 'topdmc.com'
  end

  # get /albums/:id/materials
  def materials
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 5
    @album = get_album
    @materials = @album.materials
    @covers = @album.covers
    render json: {
      albums: {
        materials: @materials,
        covers: @covers
      }
    }
  end

  # get /albums/:id/tracks
  def tracks
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @album = get_album
    @tracks = @album.tracks.recent.page(page).per(size)
    render json: {
      albums: {
        tracks: @tracks.as_json(Track.as_album_list_json_options)
      },
      meta: page_info(@tracks)
    }
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
            :covers_order,
            :original_label_number,
            :release_date,
            :release_version,
            primary_artist_ids: [],
            featuring_artist_ids: [],
            materials_attributes: [:id, :url, :native_name, :_destroy],
            covers_attributes: [:id, :url, :native_name, :_destroy],
            album_names_attributes: [:id, :name, :language_id, :_destroy]
        )
  end
end
