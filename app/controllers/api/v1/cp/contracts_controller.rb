class Api::V1::Cp::ContractsController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    provider = params[:provider_name]
    @contracts = ::Cp::Contract.recent#accessible_by(current_ability).recent
    @contracts = @contracts.joins("LEFT JOIN providers ON providers.id = cp_contracts.provider_id").where("providers.name like?","%#{provider}%") if provider.present?
    @contracts = @contracts.db_query(:contract_no, params[:contract_no]) if params[:contract_no].present?
    @contracts = @contracts.db_query(:project_no, params[:project_no]) if params[:project_no].present?
    @contracts = @contracts.date_between(params[:contract_status]) if  params[:contract_status].present?
    @contracts = @contracts.includes(:authorizes,:provider,:audits,:authorize_valids,:authorize_dues,:department).page(page).per(size)

    render json: {contracts: @contracts.as_json(::Cp::Contract.as_list_json_options), meta: page_info(@contracts)}
  end


  def show
    @contract = get_contract
    render json: {contract: @contract.as_json(::Cp::Contract.as_show_json_options)}
  end


  def create
    @contract = ::Cp::Contract.new(contract_params)
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

  #批量审核通过
   def accept
       @contracts = get_contract_list.limit(20)
       comment = '审核通过'
       @contracts.each do |contract|
         contract.accept!
         contract.create_auditables(current_user,'accept',comment)
       end
       head :ok
   end
  #拒绝通过
   def reject
       comment =  params['not_through_reason']
       @contract = ::Cp::Contract.find(params[:id])
       @contract.reject!(comment)
       @contract.create_auditables(current_user,'reject',comment)
       head :ok
   end



  private

  def get_contract
     ::Cp::Contract.find(params[:id])
  end

  def get_contract_list
      ::Cp::Contract.where(id: params[:contract_ids])
  end

  def contract_params
      params.require(:contract).permit(
            :provider_id,
            :department_id,
            :contract_no,
            :project_no,
            :start_time,
            :end_time,
            :allow_overdue,
            :desc,
            :status,
            :reason,
            :pay_type,
            :pay_amount,
            :contract_resources_attributes => [:id,:url,:file_name,:_destroy],
            :authorizes_attributes => [:id,:contract_id,:currency_id,:account_id,:end_time,:start_time,:_destroy,
              :authorized_businesses_attributes =>[:id,:authorized_range_id,:divided_point,:_destroy,:areas_count,:authorized_area_ids=>[]],
              :contract_resources_attributes => [:id,:url,:file_name,:_destroy]]
        )
  end



end
