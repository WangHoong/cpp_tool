class Api::V1::AuthorizedRangesController < Api::V1::BaseController


  def index
    @ranges = AuthorizedRange.all.order(id: :desc)
    render json: {ranges: @ranges}
  end

end
