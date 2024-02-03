# frozen_string_literal: true

require "sidekiq"

module DelayedCrud
  module Job # :nodoc:
    module SidekiqJob # :nodoc:
      class DelayedCrudJob # :nodoc:
        include Sidekiq::Worker

        sidekiq_options queue: :default, tags: ["delayed_crud_job"]

        def perform(class_name, record_id, operation, attributes = {})
          record = record_id ? class_name.constantize.find(record_id) : class_name.constantize

          case operation.to_sym
          when :create, :update
            record.send(operation, attributes)
          when :destroy
            record.send(operation)
          else
            raise ArgumentError, "Unsupported operation: #{operation}"
          end
        end
      end
    end
  end
end
