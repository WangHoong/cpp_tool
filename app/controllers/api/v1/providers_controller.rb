class Api::V1::ProvidersController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    @providers = Provider.includes(:audits).order(id: :desc)
    @providers = @providers.where(name: params[:q]) if params[:q]
    @providers = @providers.page(page).per(size)
    render json: {providers: @providers.as_json(Provider.as_list_json_options), meta: page_info(@providers)}
  end


  def show
    @provider = get_provider
    render json: {provider: @provider.as_json(Provider.as_list_json_options)}
  end

  def update
    @provider = get_provider
    @provider.status = :pending
    if @provider.update(provider_params)
      render json: {provider: @provider}
    else
      render json: @provider.errors, status: :unprocessable_entity
    end
  end

  def create
    @provider = Provider.new(provider_params)
    if @provider.save
      render json: {provider: @provider}
    else
      render json: @provider.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @provider = get_provider
    @provider.destroy
    head :ok
  end


  #批量审核通过
   def accept
       @providers = get_provider_by_ids.limit(20)
       comment = '审核通过'
       @providers.each do |provider|
         provider.without_auditing do
           provider.accept!
         end
         if provider.previous_changes.present?
          changes = {status: provider.previous_changes['status']}
          provider.create_auditables(current_user,'accept',comment,changes)
         end
       end
       head :ok
   end
  #拒绝通过
   def reject
      comment =  params['not_through_reason'] || '审核未通过'
       @provider = get_provider
       @provider.without_auditing do
         @provider.reject!(comment)
       end
       if @provider.previous_changes.present?
          changes = {status: @provider.previous_changes['status']}
          @provider.create_auditables(current_user,'reject',comment,changes)
        end
        head :ok
   end


  private
  def get_provider
    Provider.find(params[:id])
  end

  def get_provider_by_ids
     Provider.where(id: params[:provider_ids])
  end

  def provider_params
    params.require(:provider).permit(:name,:property,:data_type,:contact,:address,:email,:tel,:status,:not_through_reason,:bank_name,:account_no,:user_name,:cycle,:start_time)
  end
end
