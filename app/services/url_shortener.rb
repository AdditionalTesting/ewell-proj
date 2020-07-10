class UrlShortener
  @@api_token = Figaro.env.BITLY_TOKEN
  def self.shorten_url(url)
    client = Bitly::API::Client.new(token: @@api_token)
    bitlink = client.shorten(long_url: url).link
  end
end
