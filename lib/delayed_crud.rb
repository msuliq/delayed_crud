# frozen_string_literal: true

require "delayed_crud/version"
require "delayed_crud/railtie" if defined?(Rails::Railtie)

module DelayedCrud # :nodoc:
  class << self
    attr_accessor :queue_adapter
  end

  def self.configure
    yield self
  end

  def self.setup
    return if queue_adapter

    self.queue_adapter = :sidekiq
  end

  def self.calculate_delay(time_specification)
    raise ArgumentError, "Cannot perform transaction without time specification" unless time_specification

    if time_specification.respond_to?(:from_now)
      delay = (time_specification.from_now - Time.now).to_i
    elsif time_specification.respond_to?(:to_i)
      delay = (time_specification - Time.now).to_i
    else
      raise ArgumentError, "Invalid time specification: #{time_specification}"
    end

    unless delay.positive?
      raise ArgumentError,
            "Cannot perform #{operation} with negative time specification: #{options[:in] || options[:after]}"
    end

    delay
  end

  class Error < StandardError; end
end

DelayedCrud.setup
