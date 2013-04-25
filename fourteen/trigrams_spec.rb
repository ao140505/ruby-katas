require_relative 'trigrams'
require 'minitest/autorun'

require_relative 'english_spec'
require_relative 'array_spec'

describe "TextAnalyzer" do
  describe "#trigrams" do
    it "is a hash" do
      text = "I wish I may I wish I might"
      analyzer = TextAnalyzer.new(text)
      analyzer.trigrams.must_be_instance_of Hash
    end

    it "has a key for each trigram in the text" do
      text = "I wish I may I wish I might"
      analyzer = TextAnalyzer.new(text)
      analyzer.trigrams.keys.count.must_equal 4
    end
  end
end

