require 'minitest/autorun'
require './lib/ip7'

class TestIp7 < Minitest::Test
  def setup
    @string1 = 'abba[mnop]qrst'
    @multiple_hypernets = 'abc[123]def[456]ghij'
    @no_hypernet = 'abcdef'
    @string2 = 'abcd[bddb]xyyx'
    @string3 = 'aaaa[qwer]tyui'
    @string4 = 'ioxxoj[asdfgh]zxcvbn'
    @ip5 = IPaddress.new('aba[bab]xyz')
    @ip6 = IPaddress.new('xyx[xyx]xyx')
    @ip7 = IPaddress.new('aaa[kek]eke')
    @ip8 = IPaddress.new('zazbz[bzb]cdb')
    @ip9 = IPaddress.new('aba[12345bab3434]zzzz')
  end


  def test_parsing
    ip = IPaddress.new(@string1)
    assert_equal ip.address[0], 'abba'
    assert_equal ip.address[1], 'qrst'
    assert_equal ip.hypernet[0], 'mnop'
  end

  def test_hypernet
    ip = IPaddress.new(@multiple_hypernets)
    assert_equal ip.hypernet[0], '123'
    assert_equal ip.hypernet[1], '456'
    ip = IPaddress.new(@no_hypernet)
    assert_nil ip.hypernet
  end

  def test_abba
    assert 'abba'.abba?
    assert 'ioxxoj'.abba?
    refute 'abcdefghi'.abba?
    refute 'aaaa'.abba?
  end

  def test_tls
    ip = IPaddress.new(@string1)
    assert ip.support_tls?
    ip = IPaddress.new(@string2)
    refute ip.support_tls?
    ip = IPaddress.new(@string3)
    refute ip.support_tls?
    ip = IPaddress.new(@string4)
    assert ip.support_tls?
  end

  def test_aba
    assert 'abcd'.find_aba.empty?
    assert_equal 'aca', 'aca'.find_aba[0]
    assert_equal 'aaaaabcbaaaaabbbdgd'.find_aba.size, 2
  end

  def test_ssl
    assert @ip5.support_ssl?
    refute @ip6.support_ssl?
    assert @ip7.support_ssl?
    assert @ip8.support_ssl?
    assert @ip9.support_ssl?
  end
end
