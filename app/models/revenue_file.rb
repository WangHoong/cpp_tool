class RevenueFile < ApplicationRecord
  belongs_to :revenue
  validates :url, presence: true
  before_destroy :delete_analyses



  private
  def delete_analyses
    client = Elasticsearch::Client.new url: SETTINGS['elasticsearch_server']#,log:true
    revenue = client.delete_by_query(
      index: SETTINGS['donkey_index'],
      body: {
        query: {
          match: { 'note.revenue_file_id': self.id }
        }
      }
    )
  end
end
