class AnalysisRepository
  include Elasticsearch::Persistence::Repository

  index SETTINGS['donkey_index'].to_sym
  klass ReportAnalysis
  client Elasticsearch::Client.new url: SETTINGS['elasticsearch_server'], log: true

  def serialize(document)
    hash = document.to_hash.clone
    hash.to_hash
  end

  def deserialize(document)
    hash = document['_source']
    klass.new hash
  end
end
