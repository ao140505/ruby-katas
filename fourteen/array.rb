class Array
  def adjacent_in_groups_of(n, &block)
    raise ArgumentError.new "group size must be greater than 1" unless n > 1

    (0..self.length-n).each do |i|
      yield self[i, n]
    end
  end
end
