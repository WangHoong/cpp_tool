class Api::V1::RevenuesController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]
    @revenues = Revenue.includes(:dsp,:user).order(id: :desc).page(page).per(size)
    render json: {revenues: @revenues.as_json(Revenue.as_list_json_options),meta: page_info(@revenues)}
  end

  def show
    @revenue = get_revenue
    render json: @revenue.as_json(Revenue.as_show_json_options)
  end

  def create
    @revenue = current_user.revenues.new(revenue_params)
    if @revenue.save
      #DonkeyJob.create(task: :parse_report, target: @revenue, status: :pending)
      render json: @revenue.as_json(Revenue.as_show_json_options)
    else
      render json: @revenue.errors, status: :unprocessable_entity
    end
  end

  def update
    @revenue = get_revenue
    @revenue.assign_attributes(revenue_params)
    if @revenue.save
      render json: @revenue
    else
      render json: @revenue.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @revenue = get_revenue
    if @revenue.destroy
       head :ok
    end
  end


  # PUT /revenues/:id/processed
  #解析完成
  def processed
    @revenue = get_revenue
    if @revenue.processed!
      render json: @revenue
    else
      render json: @revenue.errors, status: :unprocessable_entity
    end
  end

  # PUT /revenues/:id/reprocess
 #summary '再次解析'
  def reprocess
    @revenue = get_revenue
    if @revenue.reprocess!
      render json: @revenue
    else
      render json: @revenue.errors, status: :unprocessable_entity
    end
  end

  # PUT /revenues/:id/confirm
 #summary '确认导入'
  def confirm
    @revenue = get_revenue
    if @revenue.confirmed!
      render json: @revenue
    else
      render json: @revenue.errors, status: :unprocessable_entity
    end
  end

  # PUT /revenues/:id/account
  #summary '确认结算'
  def account
    @revenue = get_revenue
    if @revenue.accounted!
      render json: @revenue
    else
      render json: @revenue.errors, status: :unprocessable_entity
    end
  end

  # PUT /revenues/:id/done
  #summary '结算完成'

  def done
    @revenue = get_revenue
    if @revenue.finished!
      render json: @revenue
    else
      render json: @revenue.errors, status: :unprocessable_entity
    end
  end

  # GET /revenues/:id/analyses_file
  #summary '获取解析结果'

  def analyses_file
    type = params[:type] || :succeed
    @revenue = get_revenue
    send_data Services::RevenueService.make_workbook(@revenue, type.to_sym).to_stream,
      filename: "报表##{@revenue.id}解析结果(#{type}).xlsx",
      type: "application/vnd.ms-excel"
  end

  private
  def revenue_params
    params.require(:revenue)
    .permit(
        :dsp_id,
        :start_time,
        :end_time,
        :income,
        :is_std,
        :is_split,
        :currency_id,
        revenue_files_attributes: [:id,:url,:file_name,:processed_at,:_destroy]
    )
  end

  def get_revenue
    Revenue.find(params[:id])
  end

end
