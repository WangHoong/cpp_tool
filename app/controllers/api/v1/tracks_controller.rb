class Api::V1::TracksController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @tracks = Track.recent.page(page).per(size)

    render json: @tracks, meta: page_info(@tracks)
  end

  def show
    @track = Track.find params[:id]
    render json: @track
  end

  def create
    @track = Track.new track_params

    if @track.save!
      render json: @track
    else
      render json: @track.errors
    end
  end

  def update
    @track = Track.find params[:id]
    if @track.update_attributes(track_params)
      render json: @track
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
      :remark,
      :status,
      :genre,
      :ost,
      :company,
      :lyric,
      :remark,
      :harmonic,
      :language_id,
      :provider_id,
      :contract_id,
      :authorize_id,
      artist_ids: [],
      album_ids: [],
      accompany_artists_attributes: [:id,:name,:_destroy],
      track_composers_attributes: [:id,:name,:op_type,:point,:_destroy],
      track_resources_attributes: [:id, :field, :_destroy, resource_attributes: [:id, :url, :native_name]]
     )
  end

end
