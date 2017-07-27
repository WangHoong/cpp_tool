class Api::V1::Cp::AuthorizesController < Api::V1::BaseController
  before_action :get_contract

  def index
    @authorizes = @contract.authorizes
    render json: {authorizes: @authorizes.as_json(::Cp::Authorize.as_list_json_options) }
  end


  def show
    @authorize = get_authorize
    render json: {authorize: @authorize.as_json(::Cp::Authorize.as_show_json_options) }
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
    @contract = ::Cp::Contract.find(params[:contract_id])
  end
  def get_authorize
    @contract.authorizes.find(params[:id])
  end


end
