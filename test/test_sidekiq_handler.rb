# frozen_string_literal: true

require "test_helper"
require "sidekiq/testing"

class TestSidekiqHandler < Minitest::Test
  include Sidekiq::Worker

  def setup
    ActiveRecord::Base.establish_connection(adapter: "sqlite3", database: ":memory:")

    ActiveRecord::Schema.define do
      create_table :users do |t|
        t.string :name
        t.timestamps null: false
      end
    end

    User.create(name: "John Doe")

    DelayedCrud.stub(:setup, nil) do
      DelayedCrud.queue_adapter = :sidekiq
    end
  end

  def teardown
    Sidekiq::Worker.clear_all
  end

  # rubocop:disable Metrics/AbcSize
  def test_delayed_destroy_enqueues_job_in_sidekiq
    user = User.find_by(name: "John Doe")

    user_mock = Minitest::Mock.new
    user_mock.expect(:destroy, true)
    user_mock.instance_eval do
      def id
        SecureRandom.base64(12)
      end
    end

    DelayedCrud::BackgroundJobHandler.delayed_destroy(user, after: 1.hour)

    assert_equal 1, Sidekiq::Queues["default"].size

    Timecop.travel(Time.now + 61.minutes)
    Sidekiq::Worker.drain_all

    assert_equal 0, Sidekiq::Queues["default"].size
    assert_equal false, User.exists?(name: "John Doe")
  end

  def test_delayed_create_enqueues_job_in_sidekiq
    attributes = { name: "Jane Doe" }

    DelayedCrud::BackgroundJobHandler.delayed_create(User, attributes, in: 30.minutes.from_now)

    assert_equal 1, Sidekiq::Queues["default"].size

    Timecop.travel(Time.now + 31.minutes)
    Sidekiq::Worker.drain_all

    assert_equal 0, Sidekiq::Queues["default"].size
    assert_equal true, User.exists?(name: "Jane Doe")
  end

  def test_delayed_update_enqueues_job_in_sidekiq
    user_mock = Minitest::Mock.new
    user_mock.expect(:destroy, true)
    user_mock.instance_eval do
      def id
        SecureRandom.base64(12)
      end
    end

    user = User.find_by(name: "John Doe")
    attributes = { name: "Jane Doe" }

    DelayedCrud::BackgroundJobHandler.delayed_update(user, attributes, in: 2.days.from_now)

    assert_equal 1, Sidekiq::Queues["default"].size

    Timecop.travel(Time.now + 49.hours)
    Sidekiq::Worker.drain_all

    assert_equal 0, Sidekiq::Queues["default"].size
    assert_equal true, User.exists?(name: "Jane Doe")
  end
  # rubocop:enable Metrics/AbcSize
end
