# frozen_string_literal: true

require "delayed_crud/worker/sidekiq_worker"

module DelayedCrud
  module BackgroundJobHandler
    module SidekiqHandler # :nodoc:
      def self.delayed_create(record, attributes, options)
        DelayedCrud::Worker::SidekiqWorker.perform_with_delay(operation: :create, record: record,
                                                              attributes: attributes, options: options)
      end

      def self.delayed_update(record, attributes, options)
        DelayedCrud::Worker::SidekiqWorker.perform_with_delay(operation: :update, record: record,
                                                              attributes: attributes, options: options)
      end

      def self.delayed_destroy(record, options)
        DelayedCrud::Worker::SidekiqWorker.perform_with_delay(operation: :destroy, record: record, options: options)
      end
    end
  end
end
