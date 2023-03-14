# frozen_string_literal: true

module NewsletterRss
  module Actions
    module Rss
      class Index < Hanami::Action
        def handle(request, response)
          response.body = "Welcome to Short Ruby RSS!"
        end
      end
    end
  end
end
