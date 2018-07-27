# String validation for ASIN codes
# Ref: https://www.amazon.com/gp/seller/asin-upc-isbn-info.html
module ASIN
  def asin?
    return false unless length == 10
    return true if gsub(/[^a-zA-Z0-9]/, '') == to_s
    false
  end
end

# Extend String with these methods
class String
  include ASIN
end
