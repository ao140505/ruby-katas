require_relative 'code_counter'
require 'minitest/autorun'

describe "count_lines" do
  it "can handle multi-line comments" do
    file = %q{// This file contains 3 lines of code
public interface Dave {
  /**
   * count the number of lines in a file
   */
  int countLines(File inFile); // not the real signature!
}}
    CodeCounter.count_lines(file).must_equal 3
  end

  it "handles this other file too" do
    file = %q{/*****
 * This is a test program with 5 lines of code
 *  \/* no nesting allowed!
 //*****//***/// Slightly pathological comment ending...

public class Hello {
    public static final void main(String [] args) { // gotta love Java
        // Say hello
      System./*wait*/out./*for*/println/*it*/("Hello/*");
    }

}}
    CodeCounter.count_lines(file).must_equal 5
  end
end

__END__
this is V1, where I figured out that gsub wasn't going to work ;)

def count_lines(string)
  string.gsub! /\/\*.*\*\//m, ''      # remove multi-line comments
  string.gsub! /^\s*$\n/, ''          # remove blank lines
  string.gsub! /(^|^\s*)\/\/.*\n/, '' # inline comments with no code
  string.lines.count
end
