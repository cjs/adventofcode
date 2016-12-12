require 'minitest/autorun'
require './lib/decompress'

class TestDecompress < Minitest::Test
  def setup
    @string1 = 'ADVENT'
    @string2 = 'A(1x5)BC'
    @string3 = '(3x3)XYZ'
    @string4 = 'A(2x2)BCD(2x2)EFG'
    @string5 = '(6x1)(1x3)A'
    @string6 = 'X(8x2)(3x3)ABCY'
    @string7 = '(27x12)(20x12)(13x14)(7x10)(1x12)A'
    @string8 = '(25x3)(3x3)ABC(2x3)XY(5x2)PQRSTX(18x9)(3x2)TWO(5x7)SEVEN'
  end

  def test_one
    assert_equal 'ADVENT', @string1.decompress
  end

  def test_two
    assert_equal 'ABBBBBC', @string2.decompress
  end

  def test_three
    assert_equal 'XYZXYZXYZ', @string3.decompress
  end

  def test_four
    assert_equal 'ABCBCDEFEFG', @string4.decompress
  end

  def test_five
    assert_equal '(1x3)A', @string5.decompress
  end

  def test_size
    assert_equal 'X(3x3)ABC(3x3)ABCY', @string6.decompress
  end

  def test_p21
    assert_equal 9, @string3.d2length
  end

  def test_p22
    assert_equal 'XABCABCABCABCABCABCY'.size, @string6.d2length
  end

  def test_p23
    assert_equal 241920, @string7.d2length
  end

  def test_p24
    assert_equal 445, @string8.d2length
  end
end
