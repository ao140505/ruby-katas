require 'pry'

class SearchRecursive
  class << self
    attr_accessor :left, :right, :middle, :collection, :query

    def chop(value, col)
      return -1 if col.size < 1

      setup(value, col)
      find_it
    end

    private

    # sets up variables
    def setup(value, col)
      @query = value
      @collection = col
      @left = 0
      @right = self.collection.count - 1
      @middle = self.collection.middle
    end

    # contains index finding logic
    def find_it
      if @query > @collection[@middle]
        @left = @middle
        @middle = (@right - @middle) / 2
      else
        @right = @middle
        @middle = (@middle - @left) / 2
      end
      return find_it if @right - @left > 1

      # only two values left at this point
      if @collection[@left] == @query
        @left
      elsif @collection[@right] == @query
        @right
      else
        -1
      end
    end
  end
end

class Array
  def middle
    size / 2
  end
end
