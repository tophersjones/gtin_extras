# String validation for UNSPSC codes
# NOTES 
#     - Requires internet connection to run, will fail with message 'API call failed' if HTTParty get request fails for any reason
#     - Limited to verifying 8 digit UNSPSC. Will not accept optional 2 digit 'Business Function' suffix
#     - Module will need to be updated if unspsc.org website is updated
# Refs: https://www.unspsc.org/search-code/, http://www.unspsc.org/faqs

require 'httparty'
require 'nokogiri'

module UNSPSC
  # Gets raw html from unspsc.org. If get request fails, passes error message. 
  def scrape_data
    unparsed_page = HTTParty.get("https://www.unspsc.org/search-code/default.aspx?CSS=#{to_s}")
    return unparsed_page
  rescue HTTParty::Error, SocketError => e
    puts ('API call failed')
  end

  # Parses html, gets text from last td element 
  def unspsc_title?
    unparsed_page = scrape_data()
    unparsed_page != nil ? (
      parsed_page = Nokogiri::HTML(unparsed_page)
      td_elements = parsed_page.css('td')
      title = td_elements.last.children.children.text 
      return title unless title.include? "\r"
      return 'No results found'
    ) : (
      return 'API call failed'
      )
  end

  # Using uspsc_title, determines if unspsc code is valid 
  def unspsc?
    data = unspsc_title?()
    if (data == 'API call failed')
      return 'API call failed'
    elsif (data == 'No results found')
      return false
    end
    return true
  end
end

# Extend String with these methods
class String
  include UNSPSC
end