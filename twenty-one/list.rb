class List
  attr_reader :length

  def initialize
    @length = 0
  end

  def find value
    Node.new 'aoeu'
  end

  def add value
    new_node = Node.new value
    if length == 0
      @first = new_node
    else
      last_node.next = new_node
    end
  end

  def to_a
    values = []
    current_node = @first

    until current_node.next == nil
      values << current_node.value
    end

    values
  end
end

class Node
  attr_accessor :value, :next

  def initialize value, next_node=nil
    @value = value
    @next = next_node
  end
end

require 'minitest/autorun'

class TestList < MiniTest::Unit::TestCase
  def test_add
    list = List.new
    assert_equal [], list.to_a

    list.add 'hi'
    assert_equal ['hi'], list.to_a
  end

  def test_that_it_works
    skip

    list = List.new
    assert_nil(list.find("fred"))
    list.add("fred")
    assert_equal("fred", list.find("fred").value())
    assert_nil(list.find("wilma"))
    list.add("wilma")
    assert_equal("fred",  list.find("fred").value())
    assert_equal("wilma", list.find("wilma").value())
    assert_equal(["fred", "wilma"], list.values())
  end
end
