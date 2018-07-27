# String validation for PLU codes
# Ref: https://www.ifpsglobal.com/Identification/PLU-Codes
module PLU
  def plu?
    return false unless [4, 5].include?(length)
    int = to_i
    return false unless int.to_s == to_s
    return true if (3000..4999).cover? int
    return true if (83_000..84_999).cover? int
    return true if (93_000..94_999).cover? int # organic produce
    false
  end
end

# Extend String with these methods
class String
  include PLU
end
