class Api::V1::Cp::AuthorizesController < Api::V1::ApplicationController
  before_action :get_contract

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @authorizes =  @contract.authorizes.includes(:contract,:currency,:account,:authorized_businesses,:assets).recent.page(page).per(size)
    render json: @authorizes, meta: page_info(@authorizes),root: "cp_authorizes"
  end


  def show
    @authorizes = get_authorize
    render json: @authorize
  end

  def destroy
    get_authorize.destroy
    render  json: {status: 200}, status: :ok
  end

  def areas
    @authorize =  get_authorize
    @business =  @authorize.authorized_businesses.find(params[:business_id])
    render json:  @business.authorized_areas
  end


  private

  def get_contract
    @contract = Cp::Contract.find(params[:contract_id])
  end
  def get_authorize
    @contract.authorizes.find(params[:id])
  end


end
