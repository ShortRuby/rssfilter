# frozen_string_literal: true

module NewsletterRss
  module Rss
    class Maker
      AUTHOR = -"Lucian Ghinda"
      def call(channel:, items:)
        RSS::Maker.make("2.0") do |maker|
          maker.channel.author = cdata_wrap(AUTHOR)
          maker.channel.updated = cdata_wrap(Time.now.to_s)
          maker.channel.link = cdata_wrap(channel.link)
          maker.channel.webMaster = cdata_wrap(web_master(channel))

          copy_attributes(
            %i(title language description copyright lastBuildDate itunes_author),
            source: channel,
            destination: maker.channel
          )

          items.each do |item|
            maker.items.new_item do |new_item|
              new_item.link = cdata_wrap(item.link)
              new_item.title = cdata_wrap(item.title)
              new_item.description = cdata_wrap(item.description)
            end
          end
        end
      end

      private

        def copy_attributes(attrs, source:, destination:)
          attrs.each do |attr|
            destination.send("#{attr}=", cdata_wrap(source.send(attr)))
          end
        end

        def web_master(channel)
          "#{channel.webMaster} (#{AUTHOR})"
        end

        def cdata_wrap(text) = "<![CDATA[#{text}]]>"

        def logger = NewsletterRss::App["logger"]
    end
  end
end
