require 'pry'

class SearchLooping
  class << self

    def chop(query, col)
      left = 0
      right = col.count - 1
      middle = col.count / 2

      until right - left <= 1 do
        if query > col[middle]
          left = middle
          middle = (right - middle) / 2
        else
          right = middle
          middle = (middle - left) / 2
        end
      end

      if query == col[left]
        left
      elsif query == col[right]
        right
      else
        -1
      end
    end

  end
end
