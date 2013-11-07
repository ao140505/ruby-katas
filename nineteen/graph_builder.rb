require 'rgl/adjacency'
require 'rgl/traversal'
require 'rgl/dot'
require 'pry'
require_relative 'hamming'

class WordGraph
  attr_accessor :words, :graph

  def initialize
    @words = Hash.new {|h,k| h[k] = []}
    @graph = RGL::DirectedAdjacencyGraph.new
  end

  def self.build words
    words = words.map{|w| sanitize(w) }
    builder = new()

    words.each do |w|
      builder.add_word w
    end

    builder
  end

  def self.sanitize word
    word.strip.downcase
  end

  def add_word word
    @words[word.length] << word

    neighbors = find_neighbors(word, @words[word.length])

    neighbors.each do |n|
      graph.add_edge(word, n)
    end
  end

  def find_neighbors new_word, words
    words.select do |w|
      Hamming.distance(new_word, w) == 1
    end
  end
end

require 'minitest/autorun'
describe 'WordGraph' do
  describe 'build_graph' do
    it 'builds a graph based on a list of words' do
      words = %w(cat cot dot dog car hi hello)
      graph = WordGraph.build(words)

      #graph.must_equal %w(cat cot dot dog)
      puts graph.graph
    end
  end
end
