module Hamming
  def self.distance word, other
    word.chars.zip(other.chars).count{ |a,b| a != b}
  end
end

require 'minitest/autorun'
describe 'Hamming' do
  describe 'distance' do
    it 'returns hamming distance between two words' do
      Hamming.distance('cat', 'cot').must_equal 1
      Hamming.distance('this', 'that').must_equal 2
      Hamming.distance('ruby', 'lead').must_equal 4
    end
  end
end
