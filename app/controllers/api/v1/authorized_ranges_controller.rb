class Api::V1::AuthorizedRangesController < Api::V1::BaseController


  def index
    @ranges = AuthorizedRange.all.order(id: :desc)
    #revenue = Revenue.find(1)
    # repository = AnalysisRepository.new(index: 'donkey_test')
     #repository.index = SETTINGS['donkey_index'].to_sym
     #repository.create_index! force: true
     #revenue = RevenueAnalysis.new(id: 1,text: 'test')
     #repository.save(revenue)
    #  p repository.find(1).attributes['id']

     #RevenueWorker.perform_async(1)
     render json: {ranges: @ranges}
  end

end
