# frozen_string_literal: true

module NewsletterRss
  module Rss
    class FeedResponse
      attr_reader :body, :code, :headers

      def initialize(body:, code:, headers:)
        @body = body
        @code = code
        @header = headers
      end
    end
  end
end
