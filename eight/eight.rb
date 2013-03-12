class Foo
  def initialize
    @words = []
    @combinations = []
    @words_hash = {}
  end

  def run
    load_all_words
    find_matching_words
    puts @combinations.length
  end

  def load_all_words
    File.open('/usr/share/dict/words','r').each do |word|
      word = word.strip.downcase

      if word.length == 6
        @words << word
      elsif word.length < 6
        @words_hash[word] = true
      end
    end
  end

  def find_matching_words
    @words.each do |word|
      # currently, limiting to 2 letter minimum
      (1..3).each do |i|
        left =  word[0..i]
        right = word[(i+1)..-1]

        if @words_hash.has_key?(left) && @words_hash.has_key?(right)
          @combinations << [word, left, right]
        end
      end
    end
  end
end

Foo.new.run
