# loop forwards
# [ 0 4 2 3 4 9 3]
#   if next num is smaller than largest
#     time to go backwards and see where this one goes
#     looping backwords (partially sorted now):
#     [ 0 1 2 3 4 9 3]
#       if new_num is >= current
#         insert it at the index to the right
#           how to insert exactly?
#         break and restart outer loop
#       else
#         shift val up one index
#         keep looping to find its place

class Array
  def insertion_sort
    new_array = Array(self)
    largest = new_array[0]
    new_array.each_with_index do |el, index|
      if el >= largest
        largest = el
      else
        loop do
          previous = new_array[index-1]
          if index > 0 && el < previous
            new_array[index] = previous  # shift vals up
          else
            new_array[index] = el  # insert this val
            break
          end
          index -= 1
        end
      end
    end
    new_array
  end
end

class Rack
  attr_accessor :balls

  def initialize
    @balls = []
  end

  def add(new_ball)
    balls << new_ball
    self.balls = balls.insertion_sort
  end
end

require 'minitest/autorun'

describe Rack do
  describe "#balls" do
    before do
      @rack = Rack.new
    end

    it "returns an empty array when there are no balls" do
      @rack.balls.must_equal []
    end

    it "returns balls after you add them" do
      @rack.add(12)
      @rack.balls.must_equal [12]
    end
  end

  describe "#add" do
    it "sorts balls as they are added" do
      r = Rack.new
      r.add(1)
      r.add(2)
      r.add(0)
      r.balls.must_equal [0,1,2]
    end
  end
end

describe Array do
  describe "#insertion_sort" do
    it "sorts elements" do
      a = [1,5,3]
      a.insertion_sort.must_equal [1,3,5]

      a = [1,1,1]
      a.insertion_sort.must_equal [1,1,1]

      a = [6,1,1]
      a.insertion_sort.must_equal [1,1,6]

      a = [6,-1,1]
      a.insertion_sort.must_equal [-1,1,6]

      a = [9,1]
      a.insertion_sort.must_equal [1,9]

      a = [1,2,0]
      a.insertion_sort.must_equal [0,1,2]
    end
  end
end

