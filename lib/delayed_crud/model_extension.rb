# frozen_string_literal: true

require "delayed_crud/background_job_handler"

module DelayedCrud
  module ModelExtension # :nodoc:
    extend ActiveSupport::Concern

    class_methods do
      def delayed_create(attributes, options = {})
        DelayedCrud::BackgroundJobHandler.delayed_create(new, attributes, options)
      end
    end

    def delayed_update(options = {})
      background_job_handler.delayed_update(self, options)
    end

    def delayed_destroy(options = {})
      background_job_handler.delayed_destroy(self, options)
    end

    private

    def background_job_handler
      @background_job_handler ||= DelayedCrud::BackgroundJobHandler
    end
  end
end
