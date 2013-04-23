class CodeCounter
  attr_reader :current_line, :code, :in_comment
  alias_method :in_comment?, :in_comment

  def initialize(code)
    @code = code
    @in_comment = false
  end

  def count_lines
    count = 0
    code.each_line do |line|
      @current_line = line
      comment_starting?
      count += 1 if line_of_code?
      comment_ending?
    end
    count
  end

  def comment_starting?
    if current_line.strip =~ /\/\*/ && !current_line.strip =~ /\*\//
      @in_comment = true
    end
  end

  def comment_ending?
    if current_line.strip.start_with? "*/"
      @in_comment = false
    end
  end

  def line_of_code?
    string = current_line.strip
    # last part seems weak here
    !in_comment? && !string.empty? && !string.start_with?("//")
  end
end
