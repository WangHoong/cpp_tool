class Api::V1::ReportsController < Api::V1::BaseController

  def index
    page = params.fetch(:page, 1).to_i
    size = params[:size]

    @reports = Report.includes(:dsp).order(id: :desc).page(page).per(size)
    render json: @reports, meta: page_info(@reports)
  end

  def show
    @report = Report.find params[:id]
    render json: @report
  end

  def create
    @report = Report.new(report_params)
    if @report.save
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def update
    @report = Report.find params[:id]
    @report.assign_attributes(report_params)

    if @report.save
      render json: @report
    else
      render json: @report.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @report = Report.find params[:id]

    @report.destroy
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
        :is_split
    )
  end

end