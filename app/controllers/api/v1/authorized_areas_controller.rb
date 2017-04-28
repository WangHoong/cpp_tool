class Api::V1::AuthorizedAreasController < Api::V1::BaseController


  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]

    @areas = AuthorizedArea.all.order(id: :desc)
    @areas = @areas.db_query(:name, params[:q]) if params[:q]
    @areas = @areas.page(page).per(size)

    render json: @areas,  meta: page_info(@areas)
  end

  def show
    @area = get_area
    render json: @area
  end

  def create
    @area = AuthorizedArea.new(authorized_area_params)
    if @area.save
      render json: @area
    else
      render json: @area.errors, status: :unprocessable_entity
    end
  end


  def update
    @area = get_area
    if @area.update_attributes(authorized_area_params)
      render json: @area
    else
      render json: @area.errors, status: :unprocessable_entity
    end
  end


  def destroy
    get_area.destroy
    render  json: {status: 200}, status: :ok
  end

  private
  def get_area
    AuthorizedArea.find(params[:id])
  end

  def authorized_area_params
    params
        .require(:authorized_area)
        .permit(
            :name
        )
  end
end
