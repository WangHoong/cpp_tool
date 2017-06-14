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
        coversOrder: @album.covers_order,
        materials: @materials,
        covers: @covers
      }
    }
  end

  # get /albums/query?name="..."
  def query
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    @albums = Album.where("name LIKE ?", "%#{params[:name]}%").select(:id, :name)
    render json: @albums
  end

  # get /albums/:id/tracks
  def tracks
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @album = get_album
    @tracks = @album.tracks.recent.page(page).per(size)
    render json: {tracks: @tracks.as_json(Track.as_album_list_json_options),
                   tracks_order: @album.tracks_order, meta: page_info(@tracks) }
  end

  #批量审核通过
   def accept
       @albums = get_album_by_ids.limit(20)
       comment = '审核通过'
       @albums.each do |album|
         album.without_auditing do
           album.accept!
         end
         if album.previous_changes.present?
           changes = {status: album.previous_changes['status']}
           album.create_auditables(current_user,'accept',comment,changes)
         end
       end
       head :ok
   end
  #拒绝通过
   def reject
      comment =  params['not_through_reason'] || '审核未通过'
       @album = get_album
       @album.without_auditing do
         @album.reject!(comment)
       end
       if @album.previous_changes.present?
          changes = {status: @album.previous_changes['status']}
          @album.create_auditables(current_user,'reject',comment,changes)
        end
        head :ok
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
            :cd_volume,
            :not_through_reason,
            :status,
            :remark,
            :has_explict,
            :covers_order,
            :tracks_order,
            :original_label_number,
            :release_date,
            :release_version,
            primary_artist_ids: [],
            featuring_artist_ids: [],
            materials_attributes: [:id, :url, :native_name, :_destroy],
            covers_attributes: [:id, :url, :native_name, :position, :_destroy],
            album_names_attributes: [:id, :name, :language_id, :_destroy]
        )
  end
end
