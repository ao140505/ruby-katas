module Utils
  class << self
    def sort_chars(string)
      chars = string.downcase.gsub(/[^a-z]+/, '').chars.to_a
      chars = quicksort(chars)
      chars.join
    end

    private
    def quicksort(chars)
      length = chars.length
      if length < 2 || chars.count(chars[0]) == length
        return chars
      end

      pivot = chars[rand(length)]
      lower, upper = chars.partition {|c| c < pivot}
      quicksort(lower) + quicksort(upper)
    end
  end
end

require 'minitest/autorun'

describe Utils do
  describe ".sort_chars" do
    it "sorts chars" do
      #Utils.sort_chars("ao").must_equal 'ao'
      #Utils.sort_chars("oa").must_equal 'ao'
      Utils.sort_chars("test").must_equal 'estt'
    end
  end
end

# pick random pivot
#
# break into 2 arrays (partition step)
# 1) els bigger than pivot
# 2) els smaller than pivot
