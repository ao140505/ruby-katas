module CodeCounter
  class << self
    def count_lines(string)
      until !has_block_comment? string
        start, end_at = block_comment_indices(string)
        string[start..end_at] = ''
      end
      string.lines.inject(0) do |mem, line|
        mem += 1 if has_code?(line)
        mem
      end
    end

    private

    def has_code?(string)
      !string.strip.gsub(/\/\/.*/, '').empty?
    end

    def block_comment_indices(string)     # /* ... */
      start = string.index(/\/\*/)
      end_comment = string.index(/\*\//, start) + 1
      [start, end_comment]
    end

    def has_block_comment?(string)
      # http://bit.ly/Zhofpr
      # it's crazy in order to avoid block comments within string literals
      string =~ /\/\*(?=(?:(?:[^"]*+"){2})*+[^"]*+\z)/
    end
  end
end
