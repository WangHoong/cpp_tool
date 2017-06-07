class Api::V1::AuthorizedRangesController < Api::V1::BaseController


  def index
    @ranges = AuthorizedRange.all.order(id: :desc)

     Services::RooService.validate_revenue(1)

     #Services::RooService.seach_revenue(1)

     render json: {ranges: @ranges}
  end

end
