#!/usr/bin/env ruby
require './lib/factory'

bot = {}
output = {}
values = []

re_value = /^value (\d+) goes to bot (\d+)/
re_instruct = /^bot (\d+) gives low to (\w+) (\d+) and high to (\w+) (\d+)/
instructions = File.open('input')
instructions.each do |i|
  if i[0..2] == 'bot'
    parse = i.match(re_instruct).captures
    bot_id = Integer(parse[0])
    instruct = []
    (1...parse.length).step(2).each do |index|
      target = Integer(parse[index+1])
      if parse[index] == 'object'
        instruct << output[target] ||= Output.new
      else
        instruct << (bot[target] ||= Bot.new(target))
      end
    end
    (bot[bot_id] ||= Bot.new(bot_id)).instructions = instruct
  else
    m = i.match(re_value)
    values << [Integer(m[1]), Integer(m[2])]
  end
end

values.each do |value, target|
  p "Value #{value} goes to Bot #{target}"
  (bot[target] ||= Bot.new(target)).assign(value)
end

p "Part 1"
bot.each { |k,v| p v.id if v.compares == [17, 61] }

