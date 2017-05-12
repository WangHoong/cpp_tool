class Api::V1::ArtistsController < Api::V1::BaseController

  # Get /artists
  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @artists = Artist.includes(:songs,:images,:country,:audits).recent.page(page).per(size)
    render json: @artists, meta: page_info(@artists)
  end

  # Get /artists/:id
  def show
    get_artist
    if @artist
    render json: @artist
    else
    render json: @artist.errors, status: :unprocessable_entity
    end
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

  # post /artists/approve
  def approve
    case !!params[:id]
    when true
      get_artist
      begin
          Artist.approve(artist_params, @artist)
          render json: @artist
      rescue  Workflow::NoTransitionAllowed => e
          render json: {status: 403, error: e}, status: :forbidden
      end
    else
      @artists = get_artist_by_ids
      if Artist.batchApprove(@artists)
        render json: @artists
      else
        render json: @artists.errors, status: :unprocessable_entity
      end
    end
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
            :gender_type,
            :description,
            :label_id,
            :label_name,
            :not_through_reason,
            :status,
            songs_attributes: [:id, :url, :native_name, :_destroy],
            images_attributes: [:id, :url, :native_name, :_destroy]
        )
  end
end
