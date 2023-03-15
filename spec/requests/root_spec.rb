# frozen_string_literal: true
require 'nokogiri'

RSpec.describe "Root", type: :request do
  it "it responds with RSS feed" do
    stub_request(:get, /newsletter.shortruby.com/).to_return(status: 200, body: FakeFeedResponse.feed, headers: {})

    get "/"

    expect(last_response).to be_successful

    document = Nokogiri::XML::Document.parse(last_response.body)
    expect(document.xpath("//channel")).to_not be_empty
    expect(document.xpath("//channel/title").first.text).to eq("Short Ruby Newsletter")
    expect(document.xpath("//channel/item").count).to eq(14)
  end
end
