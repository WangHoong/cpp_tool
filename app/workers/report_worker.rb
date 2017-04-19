class ReportWorker
  include Sidekiq::Worker
  sidekiq_options queue: :report, retry: true

  def perform(report_id)
    @report = Report.find report_id
    # analyse report
  end
end
