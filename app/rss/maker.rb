# frozen_string_literal: true

module NewsletterRss
  module Rss
    class Maker
      AUTHOR = -"Lucian Ghinda"
      def call(channel:, items:)
        RSS::Maker.make("2.0") do |maker|
          maker.channel.author = AUTHOR
          maker.channel.updated = Time.now.to_s
          maker.channel.link = channel.link
          maker.channel.webMaster = web_master(channel)

          copy_attributes(
            %i(title language description copyright lastBuildDate itunes_author),
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

        def web_master(channel)
          "#{channel.webMaster} (#{AUTHOR})"
        end

        def logger = NewsletterRss::App["logger"]
    end
  end
end
