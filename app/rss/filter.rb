# frozen_string_literal: true

module NewsletterRss
  module Rss
    class Filter
      KEEP_KEYS = [
        "p/edition"
      ].freeze

      def call(items)
        keep = {}

        items.each do |item|
          if include?(item, keep:)
            logger.info("Included #{item.title}/#{item.link}")
            keep[item.link] = item
          end
        end

        keep.values
      end

      private

        def include?(item, keep:)
          return false if keep.include?(item.link)
          return true if KEEP_KEYS.any? { item.link.include?(_1) }

          false
        end

        def logger = NewsletterRss::App["logger"]
    end
  end
end
