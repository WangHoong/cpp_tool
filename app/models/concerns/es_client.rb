class EsClient

  include Singleton

  def search(params)
    client.search(params.merge({
      index: SETTINGS['donkey_index']
    }))
  end

  def client
    @client ||= Elasticsearch::Client.new url: SETTINGS['elasticsearch_server']#,log: true
  end

  # delegate to client
  def method_missing(method_name, *args, &block)
    client.send(method_name.to_sym, *args, &block)
  end

end
