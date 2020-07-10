require 'open-uri'
require 'nokogiri'

class HeadingScraper
  def self.scrape_headings(url)
    site = Nokogiri::HTML(open(url))
    site.search('h1', 'h2', 'h3').map {|heading|
      heading.content
    }
  end
end
