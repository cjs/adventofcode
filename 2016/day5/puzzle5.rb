#!/usr/bin/env ruby
#
require 'digest'

def find_hash(seed, start=0)
  md5 = Digest::MD5.new
  i = start
  while md5.hexdigest(seed + i.to_s)[0..4] != '00000'
    i = i.next
  end
  return md5.hexdigest(seed + i.to_s), i
end

door_id = 'reyedfim'

start_index = 0
password = ''
0.upto(7) do 
  digest, found_index = find_hash(door_id, start_index)
  password.concat(digest[5].to_s)
  start_index = found_index.next
end

p "Door 1: #{password}"

start_index = 0
pass_array = Array.new(8)
while pass_array.include?(nil)
  digest, found_index = find_hash(door_id, start_index)
  position = digest[5].to_s
  pass_array[position.to_i] = digest[6].to_s if position.match('\d') and position.to_i < 8 and pass_array[position.to_i].nil?
  start_index = found_index.next
  p pass_array
end

p "Door 2: #{pass_array.join("")}"


