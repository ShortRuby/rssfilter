# frozen_string_literal: true

require "rss"

module NewsletterRss
  module Rss
    class Parser
      include Deps["rss.client"]

      def call(url:)
        response = client.call(url:)
        return if response.failure?

        RSS::Parser.parse(response.value!.body)
      end

      private

      def logger = NewsletterRss::App["logger"]
    end
  end
end
