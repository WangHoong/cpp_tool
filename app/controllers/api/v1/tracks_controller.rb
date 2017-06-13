class Api::V1::TracksController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @tracks = Track.includes(:albums, :artists,:audits, :contract, :provider).recent.page(page).per(size)
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
    @track = Track.find params[:id]
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

  #批量审核通过
   def accept
       @tracks = get_track_by_ids.limit(20)
       comment = '审核通过'
       @tracks.each do |track|
         track.accept!
         track.create_auditables(current_user,'accept',comment)
       end
         head :ok
   end
  #拒绝通过
   def reject
       comment =  params['not_through_reason']
       @track = Track.find(params[:id])
       @track.reject!(comment)
       @track.create_auditables(current_user,'reject',comment)
       head :ok
   end

  # POST /tracks/export
  def export
    ids = (params[:ids] || '').split(',')
    return render text: '请选择要导出的id列表' if ids.empty?

    @tracks = Track.includes(:albums, :tracks, :contract, :provider).recent.where(id: ids)
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
        :status,
        :genre_id,
        :is_agent,
        :ost,
        :label,
        :lyric,
        :remark,
        :copyright_attribution,
        :language_id,
        :track_id,
        :contract_id,
        :authorize_id,
        :provider_id,
        album_ids: [],
        track_ids: [],
        accompany_tracks_attributes: [:id, :name, :_destroy],
        track_composers_attributes: [:id, :name, :op_type, :point, :_destroy],
        track_resources_attributes: [:id, :file_type, :file_name, :url, :_destroy]
    )
  end

end
