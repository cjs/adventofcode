#!/usr/bin/env ruby
#

freqs = Array.new(8) { ('a'..'z').to_a.product([0]).to_h }

msgs = File.open('input')

msgs.each do |msg|
  msg.chomp.split('').each_index do |i|
    freqs[i][msg[i]] += 1
  end
end


ecmsg = ''
freqs.each do |freq|
  ecmsg.concat(freq.to_a.sort_by {|_, count| -count}[0][0])
end

p "Part 1: #{ecmsg}"

ecmsg2 = ''
freqs.each do |freq|
    ecmsg2.concat(freq.to_a.sort_by {|_, count| count}[0][0])
end

p "Part 2: #{ecmsg2}"
