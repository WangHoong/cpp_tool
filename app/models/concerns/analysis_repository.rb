class AnalysisRepository
  include Elasticsearch::Persistence::Repository

  def initialize(options={})
    index  options[:index] || SETTINGS['donkey_index'].to_sym
    client Elasticsearch::Client.new url: SETTINGS['elasticsearch_server'], log: true
  end
  #index SETTINGS['donkey_index'].to_sym
  #client Elasticsearch::Client.new url: SETTINGS['elasticsearch_server'], log: true
  klass RevenueAnalysis

  def serialize(document)
    hash = document.to_hash.clone
    hash.to_hash
  end

  def deserialize(document)
    hash = document['_source']
    klass.new hash
  end
end
