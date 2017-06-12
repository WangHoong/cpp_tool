class Api::V1::ProvidersController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    @providers = Provider.order(id: :desc)
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
     begin
       @providers = get_provider_by_ids.limit(20)
       comment = '审核通过'
       @providers.each do |provider|
         provider.accept!
         provider.create_auditables(current_user,'accept',comment)
       end
         head :ok
     rescue => e
         api_error(status: 500,error: e)
     end
   end
  #拒绝通过
   def reject
     comment =  params['not_through_reason']
     begin
       @provider = Provider.find(params[:id])
       @provider.reject!(comment)
       @provider.create_auditables(current_user,'reject',comment)
       head :ok
     rescue => e
       api_error(status: 500,error: e)
     end
   end






  private
  def get_provider
    Provider.find(params[:id])
  end

  def get_provider_by_ids
     Provider.where(id: params[:provider_ids])
  end

  def provider_params
    params.require(:provider).permit(:name,:property,:data_type,:contact,:address,:email,:tel,:status,:reason,:bank_name,:account_no,:user_name,:cycle,:start_time)
  end
end
