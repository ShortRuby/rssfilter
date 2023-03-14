# frozen_string_literal: true

module NewsletterRss
  module Rss
    class Transform
      include Deps["rss.parser", "rss.filter", "rss.maker"]

      def call(url:)
        feed = parser.call(url:)
        filtered_feed = filter.call(feed.items)
        maker.call(feed: filtered_feed)
      end
    end
  end
end
