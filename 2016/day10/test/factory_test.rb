require 'minitest/autorun'
require './lib/factory'

class TestFactory < Minitest::Test

  def test_bots
    bot = {}
    bot[0] = Bot.new(0)
    bot[1] = Bot.new(1)
    bot[2] = Bot.new(2)
    output = {}
    output[0] = Output.new
    output[1] = Output.new
    output[2] = Output.new
    bot[2].instructions = [bot[1], bot[0]]
    bot[1].instructions = [output[1], bot[0]]
    bot[0].instructions = [output[2], output[0]]

    bot[2].assign(5)
    bot[1].assign(3)
    bot[2].assign(2)

    assert_equal 5, output[0].slot
    assert_equal 2, output[1].slot
    assert_equal 3, output[2].slot
    assert_equal [2, 5], bot[2].compares
  end
end
