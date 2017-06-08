class Api::V1::AuthorizedRangesController < Api::V1::BaseController


  def index
    @ranges = AuthorizedRange.all.order(id: :desc)

  #   Services::RooService.validate_revenue(1)
=begin
    revenue = Revenue.first
    response = revenue.analyses_data(:succeed)
      #time = revenue.analyses_date(:succeed)
       bucket = {}
     #Services::RooService.seach_revenue(1)
     response.each do |ele|
       p ele['note']['provider_id']
       next if ele['note']['provider_id'].nil?
       provider_id = ele['note']['provider_id']
        p provider_id
       if bucket[provider_id].blank?
         bucket[provider_id] = []
       end

       bucket[provider_id] << ele
     end

=end

     render json: {ranges: @ranges}
  end

end
