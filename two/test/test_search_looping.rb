require 'minitest/autorun'
require_relative '../search_looping'

class TestSearchLooping < MiniTest::Unit::TestCase

  def test_chop
    assert_equal -1, SearchLooping.chop(3, [])
    assert_equal -1, SearchLooping.chop(3, [1])
    assert_equal 0,  SearchLooping.chop(1, [1])

    assert_equal 0,  SearchLooping.chop(1, [1, 3, 5])
    assert_equal 1,  SearchLooping.chop(3, [1, 3, 5])
    assert_equal 2,  SearchLooping.chop(5, [1, 3, 5])
    assert_equal -1, SearchLooping.chop(0, [1, 3, 5])
    assert_equal -1, SearchLooping.chop(2, [1, 3, 5])
    assert_equal -1, SearchLooping.chop(4, [1, 3, 5])
    assert_equal -1, SearchLooping.chop(6, [1, 3, 5])

    assert_equal 0,  SearchLooping.chop(1, [1, 3, 5, 7])
    assert_equal 1,  SearchLooping.chop(3, [1, 3, 5, 7])
    assert_equal 2,  SearchLooping.chop(5, [1, 3, 5, 7])
    assert_equal 3,  SearchLooping.chop(7, [1, 3, 5, 7])
    assert_equal -1, SearchLooping.chop(0, [1, 3, 5, 7])
    assert_equal -1, SearchLooping.chop(2, [1, 3, 5, 7])
    assert_equal -1, SearchLooping.chop(4, [1, 3, 5, 7])
    assert_equal -1, SearchLooping.chop(6, [1, 3, 5, 7])
    assert_equal -1, SearchLooping.chop(8, [1, 3, 5, 7])
  end
end
