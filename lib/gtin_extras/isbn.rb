# String validation for ISBN codes
# Ref: https://www.instructables.com/id/How-to-verify-a-ISBN/
# some more refs @: https://en.wikipedia.org/wiki/International_Standard_Book_Number
module ISBN
  def isbn?
    #removes any non-digits
    str = to_s.gsub(/[\D]+/, '')
    self.replace(str)
    return false unless [10, 13].include?(length)
    case length
      when 10
        return false unless (calculate_10_dig % 11 == 0)
      when 13
        return false unless (calculate_13_dig % 10 == 0)
      end
    true
  end

  # ISBN's assigned between 1970 - 2007 have 10 digits
  def calculate_10_dig
    sum = 0
    reversed_string = reverse!
    reversed_string.each_char.with_index do |char, index|
      index_plus_one = index + 1
      sum += char.to_i * index_plus_one
    end
    sum
  end

  # ISBN's became 13 digits after Jan 1, 2007
  def calculate_13_dig
    sum = 0
    reversed_string = reverse!
    reversed_string.each_char.with_index do |char, index|
      times_one_or_three = (index + 1) % 2
      if (times_one_or_three == 1)
        sum += (char.to_i * 1)
      else 
        sum += (char.to_i * 3)
      end
    end
    sum
  end
end

# Extend String with these methods
class String
  include ISBN
end