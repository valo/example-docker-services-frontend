require 'sneakers'
require 'sneakers/metrics/logging_metrics'
require 'sneakers/handlers/maxretry'
require 'json'
require_relative 'models'

opts = {
  amqp: ENV['AMPQ_ADDRESS'] || 'amqp://localhost:5672',
  vhost: '/',
  exchange: 'sneakers',
  exchange_type: :direct,
  metrics: Sneakers::Metrics::LoggingMetrics.new,
  handler: Sneakers::Handlers::Maxretry
}

Sneakers.configure(opts)
Sneakers.logger.level = Logger::INFO

class StoreResult
  include Sneakers::Worker
  from_queue :store_result

  def work(result)
    result = JSON.parse(result)
    SourceCode.find(result['source_code_id']).update!(points: result['points'], status: SourceCode::DONE)
    ack!
  end
end
