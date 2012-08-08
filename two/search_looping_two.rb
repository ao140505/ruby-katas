require 'pry'

class SearchLoopingTwo
  def self.chop(query, col)
    left = 0
    right = col.count - 1
    middle = col.count / 2

    #binding.pry if query == 5
    while right >= left do
      if query > col[middle]
        left = middle + 1
        middle = (right - middle) / 2
      elsif query < col[middle]
        right = middle - 1
        middle = (middle - left) / 2
      else
        return middle
      end
    end
    -1
  end
end
