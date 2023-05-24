# frozen_string_literal: true

module NewsletterRss
  module Actions
    module Rss
      class Index < Hanami::Action
        include Deps["rss.transform"]

        def handle(request, response)
          rss = transform.call(url: ENV.fetch("FEED_URL"))
          logger.debug("Finished #{Time.now}")
          response.format = :xml
          response.body = rss
        end

        private

          def logger = NewsletterRss::App["logger"]
      end
    end
  end
end
