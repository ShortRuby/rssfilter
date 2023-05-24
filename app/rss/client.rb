# frozen_string_literal: true

require "dry/monads"
require "typhoeus"

module NewsletterRss
  module Rss
    class Client
      include Dry::Monads[:result]
      include Deps["cache.file_store"]

      # @param [<String>] url
      #
      # @return [<NewsletterRss::Rss::Response>]
      #
      def call(url:)
        Typhoeus::Config.cache = file_store
        request = ::Typhoeus::Request.new(url.to_s, method: :get)
        response = run_request(request)

        case response
        when FeedResponse
          Success(response)
        else
          Failure(response)
        end
      end

      private

      def run_request(request)
        response = request.run

        if response.code == 400
          return error(response)
        end

        FeedResponse.new(code: response.code, body: response.body, headers: response.headers)
      rescue => e
        logger.error(e)
      end

      def error(response)
        logger.error("Invalid post: #{response.body}")
        Error.new(
          error: :invalid_feed,
          code: response.code,
          body: response.body,
          headers: response.headers
        )
      end

      def logger = NewsletterRss::App["logger"]
    end
  end
end
