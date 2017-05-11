class Report < ApplicationRecord
  enum status: [:processing, :processed, :confirmed, :accounted, :done]

  belongs_to :currency
  belongs_to :dsp
  has_many :report_resources, dependent: :destroy
	accepts_nested_attributes_for :report_resources, :allow_destroy => true
  validates :dsp_id, presence: true

  scope :date_between, lambda {|start_time, end_time| where("start_time >= ? AND end_time <= ?", start_time, end_time )}

  # state machines
  state_machine :status, initial: :processing do
    after_transition on: :accounted!, do: :split_report
    event :processed! do
      transition :processing => :processed
    end

    event :reprocess! do
      transition :processed => :processing
    end

    event :confirmed! do
      transition :processed => :confirmed
    end

    event :accounted! do
      transition :confirmed => :accounted
    end

    event :done! do
      transition :accounted => :done
    end

  end


  def analyses_data(type)
    fetch_all_analyses(type)
  end

  def analyses_report(type)
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
    success_count = es_request(:succeed)['hits']['total']
    mismatched_count = es_request(:mismatched)['hits']['total']

    if self.processing?
      "解析中"
    else
      {
        errors: file_errors,
        success: { 'total': success_count, 'report': analyses_report(:success) },
        mismatched: { 'total': mismatched_count, 'report': analyses_report(:mismatched) }
      }
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

  def split_report
    ReportWorker.perform_async(@report.id)
  end


  def fetch_all_analyses(type)
    res = []

    response = es_request(type, nil, nil, {
      search_type: 'scan',
      scroll: '1m'
    })

    begin
      response = EsClient.instance.scroll(scroll_id: response['_scroll_id'], scroll: '1m')
      res += response['hits']['hits'].map { |r| r['_source'] }
    end while response['hits']['hits'].present?

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
        category: 3,
        'report_file_id': files.last.id
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
      {term: { 'note.report_id': self.id }},
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


 	class_attribute :as_list_json_options
  self.as_list_json_options={
  			only: [:id, :dsp_id,:currency_id,:start_time,:end_time,:income,:status,:process_status,:is_std,:is_split,:created_at,:updated_at],
        include: [:report_resources]
  }


end
