class RevenueFile < ApplicationRecord
  belongs_to :revenue
  validates :url, presence: true
  before_destroy :delete_analyses



  private
  def delete_analyses
    ["analysis_error","analysis_result","analysis_info"].each do |key|
         RestClient::Request.execute(method: :delete, url: "http://#{SETTINGS['elasticsearch_server']}/donkey_dev/#{key}/_query",
                            payload: {"query":{"term":{'note.revenue_file_id': self.id }}}.to_json)
    end
  end
end
