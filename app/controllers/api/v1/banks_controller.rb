class Api::V1::BanksController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 20
    @banks = Bank.order(id: :desc).page(page).per(size)
    render json: {banks: @banks, meta: page_info(@banks)}
  end


end
