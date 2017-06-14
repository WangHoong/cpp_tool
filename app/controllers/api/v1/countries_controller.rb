class Api::V1::CountriesController < Api::V1::BaseController
  # GET /countries
  def index
    page = params.fetch(:page, 1).to_i || 1
    size = params[:size] || 50
    @countries = Country.includes(:continent).page(page).per(size)
    render json: {countries: @countries, meta: page_info(@countries)}
  end

end
