# frozen_string_literal: true

module NewsletterRss
  module Rss
    class Filter
      PAID_KEYS = [
        -"paid",
        -"Paid",
        -"PAID"
      ].freeze

      def call(items)
        keep = {}

        items.each do |item|
          unless include?(item, keep:)
            logger.info("Removed #{item.title}/#{item.link}")
            next
          end

          keep[item.title] = item
        end

        keep.values
      end

      private

      def include?(item, keep:)
        return false if keep.include?(item.title)
        return false if PAID_KEYS.any? { item.title.include?(_1) }
        return false if item.link.include?(-"paid")

        true
      end

      def logger = NewsletterRss::App["logger"]
    end
  end
end
