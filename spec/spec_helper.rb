# frozen_string_literal: true

require "pathname"
SPEC_ROOT = Pathname(__dir__).realpath.freeze

ENV["HANAMI_ENV"] ||= "test"
require "hanami/prepare"

require "webmock/rspec"
require "debug"

require_relative "support/rspec"
require_relative "support/requests"
require_relative "support/fakes/fake_item"
require_relative "support/fakes/fake_feed_response"
