class RevenueFile < ApplicationRecord
  belongs_to :revenue
  validates :url, presence: true
  before_destroy :delete_analyses


  private
  def delete_analyses
    client = Elasticsearch::Client.new url: SETTINGS['elasticsearch_server']
    revenue = client.search(
      index: SETTINGS['donkey_index'],
      body: {
        query: {
          match: { 'note.revenue_file_id': self.id }
        }
      },
      #search_type: 'scan',
      scroll: '1m'
    )

    body = []
    begin
      revenue = client.scroll(scroll_id: revenue['_scroll_id'], scroll: '1m')
      documents = revenue['hits']['hits']
      body += documents.map { |doc|
        { delete: { _index: SETTINGS['donkey_index'], _type: doc['_type'], _id: doc['_id'] } }
      }
    end while revenue['hits']['hits'].present?

    client.bulk body: body if body.present?
  end
end
