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

  private
    def get_dsp
      Dsp.find(params[:id])
    end

    def dsp_params
      params.require(:dsp).permit(:name,:department_id,:is_agent,:contact,:address,:tel,:email,:desc)
    end

end
