# frozen_string_literal: true

require "pstore"

module NewsletterRss
  module Cache
    class FileStore
      STORE_FILE = "./tmp/cache.pstore"

      def initialize(store_file = STORE_FILE, expiration = 7200)
        @store = PStore.new(store_file, true)
        @expiration = expiration
      end

      def get(request)
        key = cache_key(request)
        response = nil

        store.transaction(true) do
          if store.root?(key) && !expired?(store[key][:timestamp])
            logger.info("reading from store")
            response = store[key][:response]
          end
        end

        response
      end

      def set(request, response)
        key = cache_key(request)
        timestamp = Time.now
        store.transaction do
          store[key] = { response:, timestamp: }
        end
      end

      private

        attr_reader :store, :expiration

        def cache_key(request) = request.cache_key

        def expired?(timestamp)
          Time.now - timestamp > expiration
        end

        def logger = NewsletterRss::App["logger"]
    end
  end
end
