class Api::V1::DspsController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size] || 10
    @dsps = Dsp.includes(:department).order(id: :desc).page(page).per(size)
    render json: {dsps: @dsps.as_json(Dsp.as_list_json_options) , meta: page_info(@dsps)}
  end

  def show
    @dsp = Dsp.find(params[:id])
    render json: {dsp: @dsp.as_json(Dsp.as_list_json_options)}
  end

  def update
    @dsp = get_dsp
    @dsp.status = :pending
    if @dsp.update(dsp_params)
      render json: @dsp
    else
      render json: @dsp.errors, status: :unprocessable_entity
    end
  end

  def create
    @dsp = Dsp.new(dsp_params)
    if @dsp.save
      render json: @dsp
    else
      render json: @dsp.errors, status: :unprocessable_entity
    end
  end

  def destroy
    get_dsp.destroy
    head :ok
  end

  #批量审核通过
   def accept
       @dsps = get_dsp_by_ids.limit(20)
       comment = '审核通过'
       @dsps.each do |dsp|
         dsp.without_auditing do
           dsp.accept!
         end
         if dsp.previous_changes.present?
          changes = {status: dsp.previous_changes['status']}
          dsp.create_auditables(current_user,'accept',comment,changes)
         end
       end
       head :ok
   end
  #拒绝通过
   def reject
      comment = params['not_through_reason'] || '审核未通过'
       @dsp = get_dsp
       @dsp.without_auditing do
         @dsp.reject!(comment)
       end
       if @dsp.previous_changes.present?
          changes = {status: @dsp.previous_changes['status']}
          @dsp.create_auditables(current_user,'reject',comment,changes)
        end
        head :ok
   end


  private
    def get_dsp
      Dsp.find(params[:id])
    end

   def get_dsp_by_ids
     Dsp.where(id: params[:dsp_ids])
   end

    def dsp_params
      params.require(:dsp).permit(:name,:department_id,:is_agent,:contact,:address,:tel,:email,:desc)
    end

end
