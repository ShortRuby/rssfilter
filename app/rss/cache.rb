# frozen_string_literal: true

require "pstore"

module NewsletterRss
  module Rss
    class Cache
      STORE_FILE = "./tmp/cache/rss.pstore"

      def initialize(store_file = STORE_FILE, expiration = 86400)
        @store = PStore.new(store_file)
        @expiration = expiration
      end

      def get(url)
        response = nil

        store.transaction(true) do
          if store.root?(url) && !expired?(store[url][:timestamp])
            response = store[url][:response]
          end
        end

        response
      end

      def set(url, response)
        timestamp = Time.now

        store.transaction do
          store[url] = { response:, timestamp: }
        end
      end

      private

        attr_reader :store, :expiration

        def expired?(timestamp)
          Time.now - timestamp > expiration
        end
    end
  end
end
