class English
  SENTENCE_DELIMETERS = %w(\. ; ! \?)
  PUNCTUATION_CHARS = %w{' " , \( \) }

  class << self
    def each_sentence(text)
      regex = Regexp.new(SENTENCE_DELIMETERS.join '|')

      text.split(regex).each do |sentence|
        yield remove_punctuation(sentence.strip)
      end
    end

    def remove_punctuation(string)
      regex = Regexp.new(PUNCTUATION_CHARS.join '|')
      string.gsub regex, ''
    end
  end
end
