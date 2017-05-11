class Api::V1::CurrenciesController < Api::V1::BaseController
  def index
    @currencies = Currency.all
    render json: @currencies
  end

end
