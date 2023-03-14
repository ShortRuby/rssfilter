# frozen_string_literal: true

require_relative "../support/data/create_item"

RSpec.describe NewsletterRss::Rss::Filter do
  include CreateItem

  subject { NewsletterRss::Rss::Filter.new }

  let(:items) { [item1, item2] }

  context "when having links with paid in the path" do
    let(:item1) { new_item(title: "Short Ruby News - Edition #23", link: "https://newsletter.shortruby.com/p/edition-33") }
    let(:item2) { new_item(title: "Short Ruby News - Edition #24", link: "https://newsletter.shortruby.com/p/edition-paid-33") }

    it "removes the links with paid" do
      expect(subject.call(items)).to_not include(item2)
    end
  end

  context "when having the same title" do
    let(:item1) { new_item(title: "Short Ruby News - Edition #23", link: "https://newsletter.shortruby.com/p/edition-33") }
    let(:item2) { new_item(title: "Short Ruby News - Edition #23", link: "https://newsletter.shortruby.com/p/edition-33-23") }

    it "removes the links with paid" do
      expect(subject.call(items)).to_not include(item2)
    end
  end

  context "when title includes words like 'paid', 'PAID' or 'Paid'" do
    let(:item1) { new_item(title: "Short Ruby News - Edition #23", link: "https://newsletter.shortruby.com/p/edition-33") }
    let(:item2) { new_item(title: "Short Ruby News - Edition #23 PAID", link: "https://newsletter.shortruby.com/p/edition-33-23") }
    let(:item3) { new_item(title: "Short Ruby News - Edition #23 Paid", link: "https://newsletter.shortruby.com/p/edition-33-22") }
    let(:item4) { new_item(title: "Short Ruby News - paid Edition #23", link: "https://newsletter.shortruby.com/p/edition-33-21") }
    let(:items) { [item1, item2, item3, item4]}

    it "keeps only the items without those words" do
      expect(subject.call(items)).to_not include(item2)
    end
  end

end
