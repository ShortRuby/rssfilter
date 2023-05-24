# frozen_string_literal: true

module NewsletterRss
  module Rss
    class Maker
      def call(channel:, items:)
        logger.info("Started Maker at #{Time.now}}")
        RSS::Maker.make("2.0") do |maker|
          maker.channel.author = "Lucian Ghinda"
          maker.channel.updated = Time.now.to_s
          maker.channel.link = channel.link

          copy_attributes(
            %i(title language description copyright webMaster lastBuildDate itunes_author),
            source: channel,
            destination: maker.channel
          )

          items.each do |item|
            maker.items.new_item do |new_item|
              new_item.link = item.link
              new_item.title = item.title
              new_item.description = item.description
            end
          end
        end
      end

      private

        def copy_attributes(attrs, source:, destination:)
          attrs.each do |attr|
            destination.send("#{attr}=", source.send(attr))
          end
        end

        def logger = NewsletterRss::App["logger"]
    end
  end
end
