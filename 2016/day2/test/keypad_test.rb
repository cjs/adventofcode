require 'minitest/autorun'
require './lib/keypad'

class TestKeypad < Minitest::Test

  def test_part_one
    values = (1..9).to_a.reverse
    rows = Array.new(3,3)
    keypad = Keypad.new(rows, values)
    start = keypad[1,1]
    @nav = Navigate.new(start)
    steps = %w(U L L)
    assert_equal 1, @nav.find_button(steps).value
    steps = %w(R R D D D)
    assert_equal 9, @nav.find_button(steps).value
    steps = %w(L U R D L)
    assert_equal 8, @nav.find_button(steps).value
    steps = %w(U U U U D)
    assert_equal 5, @nav.find_button(steps).value
  end

  def test_part_two
    values = %w(1 2 3 4 5 6 7 8 9 A B C D).reverse
    rows = [1, 3, 5, 3, 1]
    keypad = Keypad.new(rows, values)
    start = keypad[2,0]
    assert_equal '5', start.value
    @nav = Navigate.new(start)
    steps = %w(U L L)
    assert_equal '5', @nav.find_button(steps).value
    steps = %w(R R D D D)
    assert_equal 'D', @nav.find_button(steps).value
    steps = %w(L U R D L)
    assert_equal 'B', @nav.find_button(steps).value
    steps = %w(U U U U D)
    assert_equal '3', @nav.find_button(steps).value
  end
end
