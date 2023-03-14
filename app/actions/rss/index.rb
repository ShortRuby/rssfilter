# frozen_string_literal: true

module NewsletterRss
  module Actions
    module Rss
      class Index < Hanami::Action
        include Deps["rss.transform"]

        def handle(request, response)
          items = transform.call
          items.each do |item|
            logger.info("Item #{item.title} with #{item.link}")
          end
          response.body = "Welcome to Short Ruby RSS!"
        end

        private

        def logger = NewsletterRss::App["logger"]
      end
    end
  end
end
