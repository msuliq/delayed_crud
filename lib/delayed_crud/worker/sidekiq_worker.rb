# frozen_string_literal: true

require "sidekiq"
require "delayed_crud/job/sidekiq_job"

module DelayedCrud
  module Worker
    module SidekiqWorker # :nodoc:
      def self.perform_with_delay(operation:, record:, attributes: {}, options: {})
        raise ArgumentError, "Missing operation for a delayed transaction" if operation.nil?

        delay = DelayedCrud.calculate_delay(options[:in] || options[:after])

        record_id = record.try(:id)
        serialized_attributes = attributes.transform_keys(&:to_s)
        class_name = record_id ? record.class.name : record.name

        Sidekiq::Client.enqueue_in(delay.seconds, DelayedCrud::Job::SidekiqJob::DelayedCrudJob, class_name, record_id,
                                   operation.to_s, serialized_attributes)
      end
    end
  end
end
