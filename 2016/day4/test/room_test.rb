require 'minitest/autorun'
require './lib/room'

class TestRoom < Minitest::Test
  def setup
    @string1 = 'aaaaa-bbb-z-y-x-123[abxyz]'
    @string2 = 'a-b-c-d-e-f-g-h-987[abcde]'
    @string3 = 'not-a-real-room-404[oarel]'
    @string4 = 'totally-real-room-200[decoy]'
    @string5 = 'qzmt-zixmtkozy-ivhz-343[fubar]'
  end


  def test_first_string
    r = Room.new(@string1)
    assert_equal 'aaaaa-bbb-z-y-x', r.name
    assert_equal 123, r.sector
    assert_equal 'abxyz', r.checksum
    assert r.valid?
  end

  def test_second_string
    r = Room.new(@string2)
    assert_equal 'a-b-c-d-e-f-g-h', r.name
    assert_equal 987, r.sector
    assert_equal 'abcde', r.checksum
    assert r.valid?
  end

  def test_third_string
    r = Room.new(@string3)
    assert_equal 'oarel', r.checksum
    assert r.valid?
  end

  def test_fourth_string
    r = Room.new(@string4)
    refute r.valid?
  end
  
  def test_decrypt
    r = Room.new(@string5)
    assert_equal 'very encrypted name', r.decrypt
  end
end
