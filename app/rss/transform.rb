# frozen_string_literal: true

module NewsletterRss
  module Rss
    class Transform
      include Deps["rss.parser", "rss.filter"]

      def call
        items = parser.call
        filter.call(items)
      end
    end
  end
end
