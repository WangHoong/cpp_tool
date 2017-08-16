include Workflow
class Revenue < ApplicationRecord

  enum status: [:processing, :processed, :confirmed, :accounted, :finished,:error]

  belongs_to :currency
  belongs_to :dsp
  belongs_to :user
  has_many :revenue_files, dependent: :destroy
	accepts_nested_attributes_for :revenue_files, :allow_destroy => true
  validates :dsp_id, presence: true
  before_save :update_files
  after_create :import_revenues

  scope :date_between, lambda {|start_time, end_time| where("start_time >= ? AND end_time <= ?", start_time, end_time )}

   workflow_column :status
   workflow do
     state :processing do
       event :process, :transitions_to => :processed
     end

     state :processed do
       event :confirm, :transitions_to => :confirmed
     end

     state :confirmed do
       event :account, :transitions_to => :accounted
     end

     state :accounted do
       event :finish, :transitions_to => :finished
     end

     state :finished

     #on_transition do |from, to, triggering_event, *event_args|
      # if to.to_s == 'accounted'
         #RevenueWorker.perform_async(self.id)
      # end
    # end

   end


  def user_name
    user.try(:name)
  end

  def dsp_name
    dsp.try(:name)
  end

  def self.as_list_json_options
     as_list_json = {
    			only: [:id, :dsp_id,:currency_id,:start_time,:end_time,:income,:status,:process_status,:is_std,:is_split,:created_at,:updated_at],
          methods: [:user_name,:dsp_name]
        }
  end

  def self.as_show_json_options
     as_list_json = {
          only: [:id, :dsp_id,:currency_id,:start_time,:end_time,:income,:status,:process_status,:is_std,:is_split,:created_at,:updated_at],
          include: [:revenue_files],
          methods: [:analyse_result,:dsp_name]
        }
  end



  attr_writer :file_urls
	def file_urls
		@file_urls ||= revenue_files.map(&:url)
	end

  def analyses_data(type)
    fetch_all_analyses(type)
  end

  def analyses_revenue(type)
    response = es_request(type, nil, {
      aggs: {
        total_price: {
          sum: {
            field: "note.income"
          }
        }
      },
      size: 0
    })
    res = response['aggregations']['total_price']['value']
    res.round(2)
  end

  def analyses_date(type)
    response = es_request(type, nil, {
      aggs: { min_date: {
          min: {
            field: "note.start_date"
          }
        },
        max_date: {
          max: {
            field: "note.end_date"
          }
        }
      }
    })
    res = response['aggregations']
    res
  end

  def analyse_result
    if self.status == :processing
      "解析中"
    else
      success_count = es_request(:succeed)['hits']['total']
      mismatched_count = es_request(:mismatched)['hits']['total']
      data = {
        errors: file_errors,
        success: { 'total': success_count, 'revenue': analyses_revenue(:success) },
        mismatched: { 'total': mismatched_count, 'revenue': analyses_revenue(:mismatched) }
      }
      return data
    end
  end

  def analyses_header
    res = es_request(:info)
    res['hits']['hits'].map do |header|
      header['_source']
    end.first
  end

  private
  def file_errors
    response = es_request(:error, nil , {
      sort: ['_doc']
    })
    response['hits']['hits'].map do |err|
      err['_source']['err_message']
    end
  end



  def update_files
		if self.revenue_files.map(&:url) != file_urls
			self.revenue_files.destroy_all
			url_params = file_urls.map do |url|
				{url: url}
			end
			self.revenue_files.new(url_params)
		end
	end

  def fetch_all_analyses(type)
    res = []
    response = es_request(type, nil, nil, {scroll: '1m'})
    res = response['hits']['hits'].map { |r| r['_source']}
      #@client ||= Elasticsearch::Client.new url: SETTINGS['elasticsearch_server'],log: true

     #p @client.scroll(scroll_id: response['_scroll_id'],scroll: '1m')
    # begin
    #  response = EsClient.instance.scroll(scroll_id: response['_scroll_id'])
    #  p response
    #  res += response['hits']['hits'].map { |r| r['_source']}
    # end while response['hits']['hits'].present?
    # p res
    res
  end

  # category:
  # 0: file error
  # 1: matched and ok
  # 2: matched but unauthorized (deprecated)
  # 3: mismatched
  def es_request(type, query = nil, options = nil, search_config = nil)
    query ||= {}

    case type.to_sym
    when :succeed
      es_type = SETTINGS['analysis_success_type']
      query.merge!({category: 1})
    when :mismatched
      es_type = SETTINGS['analysis_error_type']
      query.merge!({
        category: 3
        #'revenue_file_id': revenue_files.last.id
      })
    when :info
      es_type = SETTINGS['analysis_info_type']
      query.merge!({category: 10})
    when :error
      es_type = SETTINGS['analysis_error_type']
      query.merge!({category: 0})
    else
      es_type = SETTINGS['analysis_success_type']
      query.merge!({category: 1})
    end

    terms = [
      {term: { 'note.revenue_id': self.id }},
      {term: { '_type': es_type }}
    ]

    if query.present?
      query.each do |key, value|
        terms << {term: {key => value} }
      end
    end

    options ||= {}
    search_config ||= {}

    body = options.merge({
      query: { bool: {must: terms} }
    })

    EsClient.instance.search({
      body: body
    }.merge(search_config))
  end

  private

  def import_revenues
    RevenueImportWorker.perform_async(self.id)
  end



end
