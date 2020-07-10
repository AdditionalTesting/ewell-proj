require 'uri'

class Website < ApplicationRecord
  belongs_to :member

  validates :url, presence: true

  def populate_website_data
    self.headings = HeadingScraper.scrape_headings(url)
    self.short_url = UrlShortener.shorten_url(url)
  end
end
