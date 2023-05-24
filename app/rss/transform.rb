# frozen_string_literal: true

module NewsletterRss
  module Rss
    class Transform
      include Deps["rss.parser", "rss.filter", "rss.maker"]

      def call(url:)
        feed = parser.call(url:)
        items = filter.call(feed.items)
        maker.call(channel: feed.channel, items: items)
      end

      private

        def logger = NewsletterRss::App["logger"]
    end
  end
end
