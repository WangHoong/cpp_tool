class SettlementWorker
  include Sidekiq::Worker
  sidekiq_options queue: :settlement, retry: true
  include Sidetiq::Schedulable

  recurrence { monthly(1) }

# With default options specified explicitly
  sidekiq_retries_exhausted do |msg|
    Sidekiq.logger.warn "Failed #{msg['class']} with #{msg['args']}: #{msg['error_message']}"
  end

  def perform(settlement_id)
      @settlement = ::Cp::Settlement.find(settlement_id)
      @settlement.payment_transations

  end

end
