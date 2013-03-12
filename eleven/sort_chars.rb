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
      return [] if length < 1

      pivot = chars.delete_at(rand(length))
      lower, upper = chars.partition {|c| c < pivot}
      quicksort(lower) + [pivot] + quicksort(upper)
    end
  end
end

require 'minitest/autorun'

describe Utils do
  describe ".sort_chars" do
    it "sorts chars" do
      Utils.sort_chars("ao").must_equal 'ao'
      Utils.sort_chars("oa").must_equal 'ao'
      Utils.sort_chars("test").must_equal 'estt'
      Utils.sort_chars("aoeu").must_equal 'aeou'
      Utils.sort_chars("When not studying nuclear physics, Bambi likes to play beach volleyball."
                      ).must_equal 'aaaaabbbbcccdeeeeeghhhiiiiklllllllmnnnnooopprsssstttuuvwyyyy'
    end
  end
end

# pick random pivot
#
# break into 2 arrays (partition step)
# 1) els bigger than pivot
# 2) els smaller than pivot
