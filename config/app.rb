# frozen_string_literal: true

require "hanami"

module NewsletterRss
  class App < Hanami::App
    environment(:development) do
      config.logger.stream = root.join("log").join("development.log")
      config.logger.options[:colorize] = true
    end
  end
end
