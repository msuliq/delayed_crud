# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "active_record"
require "active_support"
require "delayed_crud"
require "delayed_crud/background_job_handler"
require "securerandom"
require "minitest/autorun"
require "timecop"

# in memory instance of User used in test cases
class User < ActiveRecord::Base
end
