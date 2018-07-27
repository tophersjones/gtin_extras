# String validation and manipulation for GTIN/EAN/GS1
module GTIN
  def gtin_structure
    return :upc if upc?
    return :ean if ean?
    return :gs1 if gs1?
    nil
  end

  def ean?
    return false unless only_gtin_digits?
    case length
    when 13
      self[12] == self[0..11].calculate_check_digit.to_s
    when 8
      self[7] == self[0..6].calculate_check_digit.to_s
    else
      false
    end
  end
  alias gln? ean?
  alias ucc? ean?

  def gs1?
    return false if length != 14
    return false unless only_gtin_digits?
    self[13] == self[0..12].calculate_check_digit.to_s
  end

  def upc?
    return false if length != 12
    return false unless only_gtin_digits?
    self[11] == self[0..10].calculate_check_digit.to_s
  end

  # FOR A UPC:
  # Ref: https://www.gs1.org/services/how-calculate-check-digit-manually
  # Ref: https://www.gtin.info/check-digit-calculator/

  def calculate_check_digit
    factor = 3
    sum = 0
    (0..(length - 1)).reverse_each do |i|
      sum += self[i].chr.to_i * factor
      factor = 4 - factor
    end
    (1000 - sum) % 10
  end

  def us_upc_checksum
    to_gtin(11).calculate_check_digit
  end

  # GTIN-12 (UPC-A): this is a 12-digit number used primarily in North America
  def to_gtin_12
    to_gtin(12)
  end
  alias to_upc   to_gtin_12
  alias to_upc_a to_gtin_12

  # GTIN-8 (EAN/UCC-8): this is an 8-digit number used primarily outside of North America
  def to_gtin_8
    to_gtin(8)
  end
  alias to_ean_8 to_gtin_8
  alias to_ucc_8 to_gtin_8

  # GTIN-13 (EAN/UCC-13): this is a 13-digit number used predominately outside of North America
  def to_gtin_13
    to_gtin(13)
  end
  alias to_ean_13 to_gtin_13
  alias to_ucc_13 to_gtin_13
  alias to_ean    to_gtin_13

  # GTIN-14 (EAN/UCC-14 or ITF-14): this is a 14-digit number used to identify trade items at various packaging levels
  def to_gtin_14
    to_gtin(14)
  end

  def to_gtin(size = 14)
    "%0#{size.to_i}d" % to_s.gsub(/[\D]+/, '').to_i
  end

  def only_gtin_digits?
    return unless length > 1
    (0..(length - 1)).reverse_each do |i|
      return nil unless self[i].chr.to_i.to_s == self[i].chr
    end
    true
  end

  def coerce_to_upc
    return self if upc?
    return unless only_gtin_digits?
    if gtin_structure == :gs1
      new_upc = to_gtin(12)
      return new_upc if new_upc.upc?
    end
    if length == 10
      new_upc = "#{to_gtin(11)}#{us_upc_checksum}"
      return new_upc if new_upc.upc?
    end
    return unless length == 11
    new_gtin_us = to_gtin(12) # assumes US-based UPC
    new_gtin_wc = "#{self}#{us_upc_checksum}"
    return nil if new_gtin_wc.upc? && new_gtin_us.upc? # avoid conflict
    return new_gtin_us if new_gtin_us.upc?
    return new_gtin_wc if new_gtin_wc.upc?
    nil
  end
end

# Extend String with these methods
class String
  include GTIN
end
