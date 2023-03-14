# frozen_string_literal: true

module NewsletterRss
  module Actions
    module Rss
      class Index < Hanami::Action
        include Deps["rss.parser"]

        def handle(request, response)
          parser.call
          response.body = "Welcome to Short Ruby RSS!"
        end
      end
    end
  end
end
