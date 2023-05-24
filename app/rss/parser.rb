# frozen_string_literal: true

require "rss"

module NewsletterRss
  module Rss
    class Parser
      include Deps["rss.client", "rss.cache"]

      def call(url:)
        cached_response = cache.get(url)
        unless cached_response.nil?
          logger.info("Using cached response for #{url}")
          return cached_response
        end

        response = client.call(url:)
        return if response.failure?

        parsed_response = RSS::Parser.parse(response.value!.body)
        cache.set(url, parsed_response)
        parsed_response
      end

      private

        def logger = NewsletterRss::App["logger"]
    end
  end
end
