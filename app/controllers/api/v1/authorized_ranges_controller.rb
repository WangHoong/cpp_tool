class Api::V1::AuthorizedRangesController < Api::V1::BaseController


  def index
    @ranges = AuthorizedRange.all.order(id: :desc)
        #Services::RooService.roo_perform(1)

       #RevenueImportWorker.perform_async(1)
     #RevenueWorker.perform_async(1)

      # ReportWork.perform_work(1)
      #  r = RevenueFile.first
      #  r.delete_analyses
     render json: {ranges: @ranges}
  end

end
