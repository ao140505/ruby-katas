describe 'English' do
  describe ".each_sentence" do
    it "takes a block and yields each sentence" do
      text = "This is a test. Here is a second sentence."
      sentences = []
      English.each_sentence(text) do |sentence|
        sentences << sentence
      end
      sentences[0].must_equal 'This is a test'
      sentences[1].must_equal 'Here is a second sentence'
    end
  end

  describe ".remove_punctuation" do
    it "removes punctuation characters from a string" do
      text = "'This() is, a \"test\"', said Billy"
      English.remove_punctuation(text).must_equal 'This is a test said Billy'
    end
  end
end

