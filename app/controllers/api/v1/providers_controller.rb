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
      render json: @provider
    else
      render json: @provider.errors, status: :unprocessable_entity
    end
  end

  def create
    @provider = Provider.new(provider_params)
    if @provider.save
      render json: @provider
    else
      render json: @provider.errors, status: :unprocessable_entity
    end
  end

  def destroy
    get_provider.destroy
    head :ok
  end

  def verify
      @provider =  Provider.find(params[:id])
      if @provider.accept! 
          head :ok
      end
  end

  def unverify
      @providers =  Provider.where(id: params[:provider_ids])
      if @providers.update_all(status: :reject,reason: params[:reason])
          head :ok
      end
  end

  private
  def get_provider
    Provider.find(params[:id])
  end

  def provider_params
    params.require(:provider).permit(:name,:property,:data_type,:contact,:address,:email,:tel,:status,:reason,:bank_name,:account_no,:user_name,:cycle,:start_time)
  end
end
