class Api::V1::TracksController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @tracks = Track.includes(:albums,:artists,:audits,:contract,:provider).recent.page(page).per(size)
    render json: {tracks: @tracks.as_json(Track.as_list_json_options), meta: page_info(@tracks)}
  end

  def show
    @track = Track.find params[:id]
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
    @track = Track.find params[:id]
    @track.destroy
  end



  private
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
      :language_id,
      :provider_id,
      :contract_id,
      :authorize_id,
      album_ids: [],
      artist_ids: [],
      accompany_artists_attributes: [:id,:name,:_destroy],
      track_composers_attributes: [:id,:name,:op_type,:point,:_destroy],
      track_resources_attributes: [:id,:file_type, :file_name,:url, :_destroy]
     )
  end

end
