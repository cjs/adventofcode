require 'minitest/autorun'
require './lib/display'

class TestDisplay < Minitest::Test
  def setup
    @pixel = Pixel.new
    @display = Display.new(7,3)
  end


  def test_pixel
    refute @pixel.lit?
    @pixel.toggle
    assert @pixel.lit?
  end

  def test_create
    assert_equal @display.grid[0].join(''), '.......'
    assert_equal @display.grid[1].join(''), '.......'
    assert_equal @display.grid[2].join(''), '.......'
  end

  def test_rect
    @display.rect(3,2)
    assert_equal @display.grid[0].join(''), '###....'
    assert_equal @display.grid[1].join(''), '###....'
    assert_equal @display.grid[2].join(''), '.......'
  end

  def test_rotate_column
    @display.rect(3,2)
    @display.rotate_column(1,1)
    assert_equal '#.#....', @display.grid[0].join('')
    assert_equal '###....', @display.grid[1].join('')
    assert_equal '.#.....', @display.grid[2].join('')
  end

  def test_rotate_row
    @display.rect(3,2)
    @display.rotate_column(1,1)
    @display.rotate_row(0,4)
    assert_equal '....#.#', @display.grid[0].join('')
    assert_equal '###....', @display.grid[1].join('')
    assert_equal '.#.....', @display.grid[2].join('')
  end

  def test_count
    @display.rect(3,2)
    assert_equal 6, @display.count
  end
end
