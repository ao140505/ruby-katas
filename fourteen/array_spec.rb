describe 'Array' do
  describe '#adjacent_in_groups_of' do
    it 'splits an array into groups and yields each group' do
      groups = []
      (1..9).to_a.adjacent_in_groups_of(3) do |group|
        groups << group
      end
      groups[0].must_equal [1,2,3]
      groups[1].must_equal [2,3,4]
      groups[-1].must_equal [7,8,9]
    end

    it 'handles different group sizes' do
      groups = []
      (1..5).to_a.adjacent_in_groups_of(2) do |group|
        groups << group
      end
      groups[0].must_equal [1,2]
      groups[1].must_equal [2,3]
      groups[-1].must_equal [4,5]
    end

    it 'raises an argument error unless group size is greater than 1' do
      proc {(1..3).to_a.adjacent_in_groups_of(1) do |group|
        group
      end}.must_raise ArgumentError
    end
  end
end
