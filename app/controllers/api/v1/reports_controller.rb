class Api::V1::ReportsController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]

    @reports = Report.includes(:dsp).order(id: :desc).page(page).per(size)
    render json: {reports: @reports}
  end

  def show
    @report = get_report
    render json: @report.as_json(Report.as_list_json_options)
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      ReportWorker.perform_async(@report.id)
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def update
    @report = get_report
    @report.assign_attributes(report_params)

    if @report.save
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @report = get_report
    @report.destroy
  end


  # PUT /reports/:id/processed
  #解析完成
  def processed
    @report = get_report
    if @report.processed!
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # PUT /reports/:id/reprocess
 #summary '再次解析'
  def reprocess
    @report = get_report
    if @report.reprocess!
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # PUT /reports/:id/confirm
 #summary '确认导入'
  def confirm
    @report = get_report
    if @report.confirmed!
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # PUT /reports/:id/account
  #summary '确认结算'
  def account
    @report = get_report
    if @report.accounted!
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # PUT /reports/:id/done
  #summary '结算完成'

  def done
    @report = get_report
    if @report.done!
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  # GET /reports/:id/analyses_file
  #summary '获取解析结果'

  def analyses_file
    type = params[:type] || :succeed
    @report = get_report
    send_data ReportService.make_workbook(@report, type.to_sym).to_stream,
      filename: "报表##{@report.id}解析结果(#{type}).xlsx",
      type: "application/vnd.ms-excel"
  end

  private
  def report_params
    params.require(:report)
    .permit(
        :dsp_id,
        :start_time,
        :end_time,
        :income,
        :is_std,
        :is_split,
        :currency_id,
        report_resources_attributes: [:id,:url,:file_name,:processed_at,:_destroy]
    )
  end

  def get_report
    Report.find(params[:id])
  end

end
