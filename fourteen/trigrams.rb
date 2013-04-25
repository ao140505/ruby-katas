require_relative 'english'
require_relative 'array'

class TextAnalyzer
  attr_reader :trigrams

  def initialize(text)
    @trigrams = Hash.new{|h, k| h[k] = []}
    @text = text
    process_text
  end

  private

  def process_text
    English.each_sentence(@text) do |sentence|
      words = sentence.split
      store_sentence_trigrams(words)
    end
  end

  def store_sentence_trigrams(words)
    words.adjacent_in_groups_of(3) do |group|
      first_two = group[0,2].join ' '
      last = group[2]
      trigrams[first_two] << last
    end
  end
end

class TextGenerator
  def initialize(trigrams)
    @trigrams = trigrams
  end

  def generate
    text = 3.times.inject([]) do |paragraphs, el|
      paragraphs += [generate_paragraph]
    end
    puts text.join "\n\n"
  end

  def generate_paragraph
    (rand(4) + 4).times.inject('') do |paragraph, el|
      paragraph += generate_sentence
    end
  end

  def generate_sentence
    sentence = ''
    key = get_random_key
    random_val = @trigrams[key].sample
    previous_two_words = [key.split[-1], random_val]
    sentence = ([key] + [random_val]).join(' ').capitalize

    (rand(15) + 3).times do |i|
      key = previous_two_words.join ' '
      random_val = @trigrams[key].sample
      if random_val.nil?
        break # no word that follows this
      else
        sentence <<  ' ' << random_val
        previous_two_words = [key.split[-1], random_val]
      end
    end
    sentence << '. '
  end

  def get_random_key
    @trigrams.keys.sample
  end
end

file = File.open('tom_swift.txt', 'rb')
analyzer = TextAnalyzer.new(file.read)
TextGenerator.new(analyzer.trigrams).generate
      #require 'pry';binding.pry
