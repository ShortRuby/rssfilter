# frozen_string_literal: true
require 'rss'

module NewsletterRss
  module Rss
    class Parser
      include Deps["rss.client"]

      def call(url: "https://newsletter.shortruby.com/feed")
        response = client.call(url:)
        return if response.failure?

        feed = RSS::Parser.parse(response.value!.body)

        feed.items.each do |item|
          logger.info("Item: #{item.title}, link: #{item.link}")
        end
      end

      private

      def logger = NewsletterRss::App["logger"]
    end
  end
end
