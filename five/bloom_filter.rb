require 'pry'
require 'fnv'

class BloomFilter
  attr_reader :bloom
  attr_accessor :size

  def initialize(opts = {})
    @size = opts[:size] || 5000000
    @bloom = Array.new(self.size).fill(0)

    load_words
  end

  def test_word(word)
    hashed = hash(word)[0]
    if self.bloom[hashed] == 0
      puts "not a word - #{word}" if debug?
      false
    else
      puts "probably, a word - #{word}, #{probability}" if debug?
      true
    end
  end

  private

  def load_words
    File.open('/usr/share/dict/words','r').each_with_index do |word, i|
      word.strip!
      add_to_bloom(word)
      @dict_size = i
    end
  end

  # returns array of integer values
  def hash(word)
    hex = FNV.new.fnv1a_32(word) % self.size
    [hex]
  end

  # flips bits in bloom if not already set
  def add_to_bloom(word)
    integers = hash(word)
    integers.each do |i|
      self.bloom[i] = 1 unless self.bloom[i] == 1
    end
  end

  def probability
    num_hashes = 1
    (((1 - Math.exp((-num_hashes * @dict_size) / self.size )) ** num_hashes) * 100).round(2).to_s +
      '% chance of false positive'
  end

  def debug?
    ENV['DEBUG'] == 'true'
  end
end

b = BloomFilter.new()
b.test_word('aoeu')
b.test_word('cat')
