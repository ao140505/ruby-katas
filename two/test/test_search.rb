require 'minitest/autorun'
require_relative '../search'

class TestSearchRecursive < MiniTest::Unit::TestCase

  def test_chop
    assert_equal -1, SearchRecursive.chop(3, [])
    assert_equal -1, SearchRecursive.chop(3, [1])
    assert_equal 0,  SearchRecursive.chop(1, [1])

    assert_equal 0,  SearchRecursive.chop(1, [1, 3, 5])
    assert_equal 1,  SearchRecursive.chop(3, [1, 3, 5])
    assert_equal 2,  SearchRecursive.chop(5, [1, 3, 5])
    assert_equal -1, SearchRecursive.chop(0, [1, 3, 5])
    assert_equal -1, SearchRecursive.chop(2, [1, 3, 5])
    assert_equal -1, SearchRecursive.chop(4, [1, 3, 5])
    assert_equal -1, SearchRecursive.chop(6, [1, 3, 5])

    assert_equal 0,  SearchRecursive.chop(1, [1, 3, 5, 7])
    assert_equal 1,  SearchRecursive.chop(3, [1, 3, 5, 7])
    assert_equal 2,  SearchRecursive.chop(5, [1, 3, 5, 7])
    assert_equal 3,  SearchRecursive.chop(7, [1, 3, 5, 7])
    assert_equal -1, SearchRecursive.chop(0, [1, 3, 5, 7])
    assert_equal -1, SearchRecursive.chop(2, [1, 3, 5, 7])
    assert_equal -1, SearchRecursive.chop(4, [1, 3, 5, 7])
    assert_equal -1, SearchRecursive.chop(6, [1, 3, 5, 7])
    assert_equal -1, SearchRecursive.chop(8, [1, 3, 5, 7])
  end
end
