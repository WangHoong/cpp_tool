class Api::V1::ArtistsController < Api::V1::BaseController

  # Get /artists
  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @artists = Artist.includes(:resources,:country).recent.page(page).per(size)
    render json: @artists, meta: page_info(@artists)
  end

  # Get /artists/:id
  def show
    render json: get_artist
  end

  # Put /artists/:id
  def update
    get_artist
    if @artist.update(artist_params)
    render json: @artist
    else
    render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # Post /artists
  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      render json: @artist
    else
      render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # Delete /artists/:id
  def destroy
    get_artist
    if @artist.destroy
    render json: @artist
    else
    render json: @artist.errors, status: :unprocessable_entity
    end
  end

  # Put /artists/approve
  def approve
    @artists = get_artist_by_ids
    @artists.update_all(approve_status: :agree, updated_at: DateTime.now)
		render json: @artists
  end

  private
  def get_artist
    @artist ||= Artist.find(params[:id])
  end

  def get_artist_by_ids
		Artist.where(id: params[:artist_ids])
	end

  def artist_params
    params
        .require(:artist)
        .permit(
            :name,
            :country_id,
            :country_name,
            :gender_type,
            :description,
            :label_id,
            :label_name,
            :not_through_reason,
            :approve_status,
            resources_attributes: [:id, :url, :native_name, :field, :status]
        )
  end
end
