class Api::V1::AlbumsController < Api::V1::BaseController
  # Get /albums
  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    @albums = Album.includes(:tracks,:primary_artists,:audits,:multi_languages).recent
    @albums = @albums.db_query(:name,params[:name]) if params[:name].present?
    @albums = @albums.db_query(:label,params[:label]) if params[:label].present?
    @albums = @albums.where(status: params[:status]) if params[:status].present?
    @albums = @albums.where(upc: params[:upc]) if params[:upc].present?
    @albums = @albums.joins("LEFT JOIN artist_albums ON artist_albums.album_id=albums.id LEFT JOIN artists ON artist_albums.artist_id=artists.id ").where("artists.name=?",params[:artist_name]) if params[:artist_name].present?
    @albums = @albums.where("release_date >= ? and release_date <=?",params[:start_time],params[:end_time]) if params[:start_time].present? and params[:end_time].present?
    @albums = @albums.page(page).per(size)
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
    @album = get_album
    @album.status = :pending
    if @album.update(album_params)
      render json: @album
    else
      render json: @album.errors, status: :unprocessable_entity
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
    return render text: '一次最多导出2000条数据' if ids.length > 2000

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
      materials: @materials,
      covers: @covers
    }
  end

  # get /albums/:id/tracks
  def tracks
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @album = get_album
    @tracks = @album.tracks.position_order.page(page).per(size)
    render json: {
      tracks: @tracks.as_json(Track.as_relationship_list_json_options),
      meta: page_info(@tracks)
    }
  end

  #批量审核通过
   def accept
       @albums = get_albums_by_ids.limit(20)
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
            :genre_id,
            :sub_genre_id,
            :format,
            :label,
            :upc,
            :cd_volume,
            :not_through_reason,
            :status,
            :remark,
            :has_explict,
            :original_label_number,
            :release_date,
            :release_version,
            :p_line_copyright,
            primary_artist_ids: [],
            featuring_artist_ids: [],
            materials_attributes: [:id, :url, :native_name, :_destroy],
            covers_attributes: [:id, :url, :native_name, :position, :_destroy],
            multi_languages_attributes: [:id, :name, :language_id, :_destroy],
            tracks_attributes: [:id, :position]
        )
  end
end
