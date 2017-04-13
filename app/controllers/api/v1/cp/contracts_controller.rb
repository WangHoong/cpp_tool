class Api::V1::Cp::ContractsController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @contracts = Cp::Contract.all#accessible_by(current_ability).recent
    @contracts = @contracts.joins("LEFT JOIN providers ON providers.id = cp_contracts.provider_id").where("providers.name like ?","%#{provider}%") if provider.present?
    @contracts = @contracts.db_query(:contract_no, params[:contract_no]) if params[:contract_no].present?
    @contracts = @contracts.db_query(:project_no, params[:project_no]) if params[:project_no].present?
    @contracts = @contracts.date_between(params[:status]) if  params[:status].present?
    @contracts = @contracts.joins("LEFT JOIN authorizes ON authorizes.contract_id = cp_contracts.id").auth_between(params[:auth_status]) if params[:auth_status].present?
    @contracts = @contracts.includes(:authorizes,:audits,:authorize_valids,:authorize_dues).page(page).per(size)

    render json: @contracts, meta: page_info(@contracts)
  end


  def show
    @contracts = get_contract
    render json: @contract
  end


  def create
    @contract = Cp::Contract.new(contract_params)
    if @contract.save
      render json: @contract
    else
      render json: @contract, status: :unprocessable_entity
    end
  end



  def update
    @contract = get_contract
    if @contract.update_attributes(contract_params)
      render json: @contract
    else
      render json: @contract.errors, status: :unprocessable_entity
    end
  end



  def destroy
    get_contract.destroy
    render  json: {status: 200}, status: :ok
  end

  def verify
      @contracts =  Contract.where(id: params[:contract_ids])
      @contracts.update_all(status: :agree)
  end

  private

  def get_contract
     Contract.find(params[:id])
  end

  def contract_params
    post = params.require(:contract).permit(
            :department_id,
            :contract_no,
            :project_no,
            :start_time,
            :end_time,
            :allow_overdue,
            :desc,
            :status,
            :pay_type,
            :pay_amount,
            :assets => [:id,:url,:filename,:_destroy],
            :authorizes => [:id,:contract_id,:currency_id,:account_id,:end_time,:start_time,:_destroy,
              :authorized_businesses =>[:id,:business_id,:business_type,:divided_point,:is_whole,:_destroy,:areas_count,:authorized_area_ids=>[]],
              :assets => [:id,:url,:filename,:_destroy]]
        )
        post.to_h.deep_transform_keys{ |key|['assets','authorizes','authorized_businesses'].include?(key) ? key+'_attributes' : key}
  end



end
