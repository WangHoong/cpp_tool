class Cp::AuthorizesController < ApplicationController
  before_action :get_contract

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @authorizes =  @contract.authorizes.includes(:contract,:currency,:account,:authorized_businesses,:contract_files).recent.page(page).per(size)
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
    @contract =  Cp::Contract.find(params[:contract_id])
  end
  def get_authorize
    @contract.authorizes.find(params[:id])
  end

  def authorize_params
    params.require(:authorize)
        .permit(
            :contract_id,
            :currency_id,
            :account_id,
            :end_time,
            :start_time,
            :tracks_count,
            :track_ids=>[],
            :authorized_businesses=>[:id,:business_id,:business_type,:divided_point,:is_whole,:_destroy,:authorized_area_ids=>[]],
            :assets => [:id,:url,:filename,:_destroy]
           ).transform_keys{ |key| ['authorized_businesses','assets'].include?(key) ? key+'_attributes' : key}
  end
end
