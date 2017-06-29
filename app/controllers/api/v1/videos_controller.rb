class Api::V1::VideosController < Api::V1::BaseController
  # Get /videos
  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    @videos = Video.includes(:audits).recent
    @videos = @videos.db_query(:name,params[:name]) if params[:name].present?
    @videos = @videos.db_query(:label,params[:label]) if params[:label].present?
    @videos = @videos.where(status: params[:status]) if params[:status].present?
    @videos = @videos.joins("LEFT JOIN artist_videos ON artist_videos.video_id=videos.id LEFT JOIN artists ON artist_videos.artist_id=artists.id ").where("artists.name=?",params[:artist_name]) if params[:artist_name].present?
    @videos = @videos.where("release_date >= ? and release_date <=?",params[:start_time],params[:end_time]) if params[:start_time].present? and params[:end_time].present?
    @videos = @videos.page(page).per(size)
    render json: @videos,
      each_serializer: Api::V1::Videos::IndexSerializer,
      meta: page_info(@videos)
  end

  # Get /query?artist_id=1
  def query
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    resource = Artist.find(params.fetch(:artist_id)) if params.fetch(:artist_id, 0) != 0
    resource = Album.find(params.fetch(:album_id)) if params.fetch(:album_id, 0) != 0
    resource = Album.find(params.fetch(:track_id)) if params.fetch(:track_id, 0) != 0
    @videos = resource.videos.page(page).per(size)
    puts @videos.to_json
    render json: @videos,
      each_serializer: Api::V1::Videos::QuerySerializer,
      meta: page_info(@videos)
  end

  # Get /videos/:id
  def show
    render json: get_video,
      serializer: Api::V1::Videos::ShowSerializer
  end

  # Put /videos/:id
  def update
    @videos = get_video
    if @videos.update(video_params)
      render json: @videos
    else
      render json: @videos.errors, status: :unprocessable_entity
    end
  end

  # Post /videos
  def create
    @video = Video.new(video_params)
    if @video.save
      render json: @video
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  # Delete /videos/:id
  def destroy
    @video = get_video
    if @video.destroy
      render json: @video
    else
      render json: @video.errors, status: :unprocessable_entity
    end
  end

  # get /videos/:id/tracks
  def tracks
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @video = get_video
    @tracks = @video.tracks.position_order.page(page).per(size)
    render json: {
      tracks: @tracks.as_json(Track.as_relationship_list_json_options),
      meta: page_info(@tracks)
    }

  end

  # get /videos/:id/albums
  def albums
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @video = get_video
    @albums = @video.albums.recent.page(page).per(size)
    render json: @albums,
      each_serializer: Api::V1::Videos::AlbumSerializer,
      meta: page_info(@albums)
  end

  # get /videos/:id/materials
  def materials
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 5
    @video = get_video
    @videos = @video.videos
    @covers = @video.covers
    render json: {
      videos: @videos,
      covers: @covers
    }
  end

  #批量审核通过
   def accept
       @videos = get_videos_by_ids.limit(20)
       comment = '审核通过'
       @videos.each do |video|
         video.without_auditing do
           video.accept!
         end
         if video.previous_changes.present?
           changes = {status: video.previous_changes['status']}
           video.create_auditables(current_user,'accept',comment,changes)
         end
       end
       head :ok
   end
  #拒绝通过
   def reject
      comment =  params['not_through_reason'] || '审核未通过'
       @video = get_video
       @video.without_auditing do
         @video.reject!(comment)
       end
       if @video.previous_changes.present?
          changes = {status: @video.previous_changes['status']}
          @video.create_auditables(current_user,'reject',comment,changes)
        end
        head :ok
   end

  private
  def get_video
    Video.find(params[:id])
  end

  def get_videos_by_ids
    Video.where(id: params[:video_ids])
  end

  def video_params
    params
        .require(:video)
        .permit(
            :name,
            :format,
            :label,
            :not_through_reason,
            :status,
            :remark,
            :release_date,
            primary_artist_ids: [],
            featuring_artist_ids: [],
            track_ids: [],
            album_ids: [],
            videos_attributes: [:id, :url, :native_name, :_destroy],
            covers_attributes: [:id, :url, :native_name, :position, :_destroy],
            multi_languages_attributes: [:id, :name, :language_id, :_destroy]
            # tracks_attributes: [:id, :position]
        )
  end
end
