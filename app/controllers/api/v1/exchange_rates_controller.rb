class Api::V1::ExchangeRatesController < Api::V1::BaseController

  # Get /exchange_rates
  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @rate = ExchangeRate.includes(:currency, :settlement_currency).recent.page(page).per(size)
    render json: @rate, meta: page_info(@rate)
  end

  # Get /exchange_rates/:id
  def show
    render json: get_exchange_rate
  end

  # Put /exchange_rates/:id
  def update
    get_exchange_rate
    if @rate.update(exchange_rate_params)
    render json: @rate
    else
    render json: @rate.errors, status: :unprocessable_entity
    end
  end

  # Post /exchange_rates
  def create
    @rate = ExchangeRate.new(exchange_rate_params)
    if @rate.save
      render json: @rate
    else
      render json: @rate.errors, status: :unprocessable_entity
    end
  end

  # Delete /exchange_rates/:id
  def destroy
    get_exchange_rate
    if @rate.destroy
    render json: @rate
    else
    render json: @rate.errors, status: :unprocessable_entity
    end
  end

  private
  def get_exchange_rate
    @rate ||= ExchangeRate.find(params[:id])
  end

  def exchange_rate_params
    params
        .require(:exchange_rate)
        .permit(
            :currency_id,
            :settlement_currency_id,
            :exchange_ratio,
            :status,
            :operator
        )
  end
end
