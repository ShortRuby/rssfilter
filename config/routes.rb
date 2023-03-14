# frozen_string_literal: true

module NewsletterRss
  class Routes < Hanami::Routes
    root to: "rss.index"
  end
end
