# frozen_string_literal: true

module FakeFeedResponse
  module_function

  def feed
    File.read(File.dirname(__FILE__) + "/feed.xml")
  end
end
