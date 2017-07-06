class Api::V1::Cp::SettlementsController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @settlements = ::Cp::Settlement.includes(:provider).recent
    @settlements = @settlements.where("settlement_cycle_start >= ?" ,params[:settlement_cycle_start]) if params[:settlement_cycle_start].present?
    @settlements = @settlements.where("settlement_cycle_end <= ?" , params[:settlement_cycle_end]) if params[:settlement_cycle_end].present?
    @settlements = @settlements.where(status: params[:status]) if params[:status].present?
    @settlements = @settlements.page(page).per(size)

    render json: {settlements: @settlements.as_json(::Cp::Settlement.as_list_json_options), meta: page_info(@settlements) }
  end

 #待结算
  def confirm
    @settlement = ::Cp::Settlement.find(params[:id])
    if @settlement.confirm!
       head :ok
    end
  end

 def payment
   @settlement = ::Cp::Settlement.find(params[:id])
   if @settlement.paymented!
      head :ok
   end
 end


end
