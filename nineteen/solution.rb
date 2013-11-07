require 'rgl/adjacency'
require 'rgl/traversal'
require 'rgl/dot'

def puts(*args)
  super(*args) if true
end

class PathFinder
  def initialize graph
    @graph = graph
  end

  def shortest_path(start, goal)
    closed_set = Set.new        # nodes already evaluated
    open_set = Set.new [start]  # nodes to be evaluated
    came_from = {}              # nodes already visited

    g_score, f_score = {}, {}
    g_score[start] = 0
    f_score[start] = g_score[start] + 1

    while !open_set.empty?
      current = best_next_word(open_set, goal)
      puts current
      if current == goal
        puts reconstruct_path(came_from, goal).join ' -> '
        return reconstruct_path(came_from, goal)
      end

      open_set.delete current
      closed_set.add current

      @graph.each_adjacent(current) do |neighbor|
        tentative_g_score = g_score[current] + 1
        if closed_set.include?(neighbor) && tentative_g_score >= g_score[neighbor]
          next
        end

        if !closed_set.include?(neighbor) || tentative_g_score < g_score[neighbor]
          came_from[neighbor] = current
          g_score[neighbor] = tentative_g_score
          f_score[neighbor] = g_score[neighbor] + heuristic_cost_estimate(neighbor, goal)

          unless open_set.include? neighbor
            open_set.add neighbor
          end
        end
      end
    end
  end

  # trys to find a word that is one character closer to the goal
  # TODO: base this on hamming distance
  def best_next_word(set, goal)
    set.to_a[0]
  end

  def reconstruct_path(came_from, current_node)
    if came_from.include? current_node
      p = reconstruct_path(came_from, came_from[current_node])
      p + [current_node]
    else
      [current_node]
    end
  end

  def heuristic_cost_estimate neighbor, goal
    1
  end
end

require 'minitest/autorun'
describe 'PathFinder' do
  describe 'shortest_path' do
    describe 'with a small graph' do
      it 'finds the path from cat to dog' do
        graph = RGL::AdjacencyGraph.new
        graph.add_edge('cat', 'car')
        graph.add_edge('cat', 'cot')
        graph.add_edge('cot', 'dot')
        graph.add_edge('dot', 'dog')

        p = PathFinder.new(graph)
        p.shortest_path('cat', 'dog').must_equal %w(cat cot dot dog)
      end
    end
  end
end
