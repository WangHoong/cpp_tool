class Api::V1::TransationsController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 20
    @provider = Provider.find(params[:provider_id])
    @transations =  @provider.transations.page(page).per(size)
    render json: {transations: @transations.as_json(Transation.as_list_json_options), meta: page_info(@transations)}
  end


end
