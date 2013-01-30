require 'pry'
require_relative 'filter'

class Foo
  def initialize
    @words = []
  end

  def run
    load_all_words
    find_matching_words
    puts @special_words.length
    binding.pry
  end

  def load_all_words
    File.open('/usr/share/dict/words','r').each do |word|
      word.strip!
      @words += [word] if word.length == 6
    end
  end

  def find_matching_words
    @special_words = []
    filter = Filter.new

    @words.each do |word|
      # currently, limiting to 2 letter minimum
      (1..3).each do |i|
        left =  word[0..i]
        right = word[(i+1)..-1]

        if filter.is_word?(left) && filter.is_word?(right)
          @special_words << [word, left, right]
        end
      end
    end
  end
end

Foo.new.run
