class Api::V1::CopyrightsController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    @provider = Provider.find(params[:provider_id])
    @copyrights = @provider.copyrights.order(id: :desc).page(page).per(size)
    render json: {copyrights: @copyrights, meta: page_info(@copyrights)}
  end



end
