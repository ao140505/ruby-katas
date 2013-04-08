# what is a line of code?
# one or more characters outside of a comment, followed by a \n
# keep reading string by searching for \n chars
# if in block comment, find first */
class CodeCounter
  def initialize(code_block)
    @code = code_block
    @line_count = 0
  end

  def count_lines(string=@code)
    return @line_count if string.empty?
    current_line = string.lines.first
    if has_block_comment? current_line
      start, end_at = block_comment_indices(string)
      string [start..end_at] = ''
      return count_lines(string)
    end
    if has_code?(current_line)
      @line_count += 1
    end
    count_lines(string[current_line.length..-1])
  end

  private

  def has_code?(string)
    !string.strip.gsub(/\/\/.*/, '').empty?
  end

  def block_comment_indices(string)
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
