class Dependencies
  def initialize
    @visited = []
    @dependencies = Hash.new {|h,k| h[k] = []}
  end

  def add_direct item, new_dependencies
    @dependencies[item] += new_dependencies
  end

  def dependencies_for item
    direct = @dependencies[item]
    direct -= @visited
    return [] if direct.empty?
    #require 'pry';binding.pry

    @visited << item
    foo = direct.inject(direct) do |memo, dependency|
      memo += dependencies_for dependency
    end.uniq.sort
    foo
  end
end

require 'minitest/autorun'
describe 'Dependencies' do
  it 'works' do
    dep = Dependencies.new
    dep.add_direct('A', %w{ B C } )
    dep.add_direct('B', %w{ C E } )
    dep.add_direct('C', %w{ G   } )
    dep.add_direct('D', %w{ A F } )
    dep.add_direct('E', %w{ F   } )
    dep.add_direct('F', %w{ H   } )

    #dep.dependencies_for('A').must_equal %w{ B C E F G H }
    dep.dependencies_for('B').must_equal %w{ C E F G H }
    dep.dependencies_for('C').must_equal %w{ G }
    dep.dependencies_for('D').must_equal %w{ A B C E F G H }
    dep.dependencies_for('E').must_equal %w{ F H }
    dep.dependencies_for('F').must_equal %w{ H }
  end

  it 'with circular dependencies!!!' do
    # fails
    dep = Dependencies.new
    dep.add_direct('A', %w{ B } )
    dep.add_direct('B', %w{ A } )

    dep.dependencies_for('A').must_equal %w{ B }
  end
end
