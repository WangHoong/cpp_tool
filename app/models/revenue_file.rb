class RevenueFile < ApplicationRecord
  belongs_to :revenue
  validates :url, presence: true
  before_destroy :delete_analyses



  private
  def delete_analyses
    client = Elasticsearch::Client.new url: SETTINGS['elasticsearch_server']#,log:true
    ["analysis_error","analysis_result","analysis_info"].each do |type_name|
      revenue = client.delete_by_query(
        index: SETTINGS['donkey_index'],
        type: type_name,
        body: {
          query: {
            match: { 'note.revenue_file_id': self.id }
          }
        }
      )
    end
  end
end
