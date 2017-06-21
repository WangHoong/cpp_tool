class Api::V1::TracksController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 20
    @tracks = Track.includes(:albums,:artists,:audits,:contract,:provider).recent
    @tracks =  @tracks.db_query(:title,params[:title]) if params[:title].present?
    @tracks =  @tracks.where(isrc: params[:isrc]) if params[:isrc].present?
    @tracks =  @tracks.where(:status ,params[:status]) if params[:status].present?
    @tracks =  @tracks.joins("LEFT JOIN albums_tracks ON albums_tracks.track_id=tracks.id LEFT JOIN albums on albums_tracks.album_id=albums.id").where("albums.name=?",params[:album_name]) if params[:album_name].present?
    @tracks =  @tracks.joins("LEFT JOIN artist_tracks ON artist_tracks.track_id=tracks.id LEFT JOIN artists on artist_tracks.track_id=artists.id").where("artists.name=?",params[:artist_name]) if params[:artist_name].present?
    @tracks =  @tracks.page(page).per(size)
    render json: {tracks: @tracks.as_json(Track.as_list_json_options), meta: page_info(@tracks)}
  end

  def show
    @track = get_track

    render json: {track: @track.as_json(Track.as_show_json_options)}
  end

  def create
    @track = Track.new track_params

    if @track.save!
      render json: {track: @track}
    else
      render json: @track.errors
    end
  end

  def update
    @track = get_track
    @track.status = :pending
    if @track.update_attributes(track_params)
      render json: {track: @track}
    else
      render json: @track.errors
    end
  end

  def destroy
    @track = get_track
    @track.destroy
  end

  def albums
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 20
    @track = get_track
    @albums = @track.albums.recent.page(page).per(size)
    render json: {albums: @albums, meta: page_info(@albums)}
  end

  #批量审核通过
   def accept
       @tracks = get_track_by_ids.limit(20)
       comment = '审核通过'
       @tracks.each do |track|
         track.without_auditing do
           track.accept!
         end
         if track.previous_changes.present?
          changes = {status: track.previous_changes['status']}
          track.create_auditables(current_user,'accept',comment,changes)
         end
       end
       head :ok
   end
  #拒绝通过
   def reject
      comment =  params['not_through_reason'] || '审核未通过'
       @track = get_track
       @track.without_auditing do
         @track.reject!(comment)
       end
       if @track.previous_changes.present?
          changes = {status: @track.previous_changes['status']}
          @track.create_auditables(current_user,'reject',comment,changes)
        end
        head :ok
   end

  # POST /tracks/export
  def export
    ids = (params[:ids] || '').split(',')
    return render text: '请选择要导出的id列表' if ids.empty?
    return render text: '一次最多导出2000条数据' if ids.length > 2000

    @tracks = Track.includes(:albums, :artists, :contract, :provider).recent.where(id: ids)
    render xlsx: 'tracks/export.xlsx.axlsx', filename: '歌曲列表.xlsx', xlsx_author: 'topdmc.com'
  end

  private

  def get_track
    Track.find params[:id]
  end

  def get_track_by_ids
    Track.where(id: params[:track_ids])
  end

  def track_params
    params.fetch(:track, {}).permit(
        :title,
        :isrc,
        :genre_id,
        :is_agent,
        :ost,
        :label,
        :label_code,
        :lyric,
        :remark,
        :pline,
        :cline,
        :copyright,
        :version,
        :copyright_attribution,
        :language_id,
        :contract_id,
        :authorize_id,
        :provider_id,
        album_ids: [],
        primary_artist_ids: [],
        featuring_artist_ids: [],
        track_composers_attributes: [:id, :name, :op_type, :point, :_destroy],
        multi_languages_attributes: [:id, :name, :language_id, :_destroy],
        track_resources_attributes: [:id, :file_type, :file_name, :url, :_destroy]
    )
  end

end
