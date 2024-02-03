# frozen_string_literal: true

Dir[File.expand_path("background_job_handler/*.rb", __dir__)].sort.each do |file|
  require_relative file
end

module DelayedCrud
  module BackgroundJobHandler # :nodoc:
    module_function

    def delayed_create(record, attributes, options = {})
      handler_instance.delayed_create(record, attributes, options)
    end

    def delayed_update(record, attributes, options = {})
      handler_instance.delayed_update(record, attributes, options)
    end

    def delayed_destroy(record, options = {})
      handler_instance.delayed_destroy(record, options)
    end

    def handler_instance
      handler_class = "#{DelayedCrud.queue_adapter.to_s.capitalize}Handler"
      DelayedCrud::BackgroundJobHandler.const_get(handler_class)
    end
  end
end
