# frozen_string_literal: true

module NewsletterRss
  module Rss
    class Maker
      def call(feed)
        RSS::Maker.make("atom") do |maker|
          maker.channel.author = feed.channel.author
          maker.channel.updated = feed.channel.updated
          maker.channel.about = feed.channel.about
          maker.channel.title = feed.channel.title

          feed.items.each do |item|
            maker.items.new_item do |new_item|
              new_item.link = item.link
              new_item.title = item.title
              new_item.updated = item.updated
              new_item.description = item.description
            end
          end
        end
      end
    end
  end
end
