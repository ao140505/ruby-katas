require 'minitest/autorun'
require_relative '../search_looping_two'

class TestSearchLoopingTwo < MiniTest::Unit::TestCase

  def test_chop
    assert_equal -1, SearchLoopingTwo.chop(3, [])
    assert_equal -1, SearchLoopingTwo.chop(3, [1])
    assert_equal 0,  SearchLoopingTwo.chop(1, [1])

    assert_equal 0,  SearchLoopingTwo.chop(1, [1, 3, 5])
    assert_equal 1,  SearchLoopingTwo.chop(3, [1, 3, 5])
    assert_equal 2,  SearchLoopingTwo.chop(5, [1, 3, 5])
    assert_equal -1, SearchLoopingTwo.chop(0, [1, 3, 5])
    assert_equal -1, SearchLoopingTwo.chop(2, [1, 3, 5])
    assert_equal -1, SearchLoopingTwo.chop(4, [1, 3, 5])
    assert_equal -1, SearchLoopingTwo.chop(6, [1, 3, 5])

    assert_equal 0,  SearchLoopingTwo.chop(1, [1, 3, 5, 7])
    assert_equal 1,  SearchLoopingTwo.chop(3, [1, 3, 5, 7])
    assert_equal 2,  SearchLoopingTwo.chop(5, [1, 3, 5, 7])
    assert_equal 3,  SearchLoopingTwo.chop(7, [1, 3, 5, 7])
    assert_equal -1, SearchLoopingTwo.chop(0, [1, 3, 5, 7])
    assert_equal -1, SearchLoopingTwo.chop(2, [1, 3, 5, 7])
    assert_equal -1, SearchLoopingTwo.chop(4, [1, 3, 5, 7])
    assert_equal -1, SearchLoopingTwo.chop(6, [1, 3, 5, 7])
    assert_equal -1, SearchLoopingTwo.chop(8, [1, 3, 5, 7])
  end
end
