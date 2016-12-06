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
0.upto(7) do |i|
  digest, found_index = find_hash(door_id, start_index)
  password.concat(digest[5].to_s)
  start_index = found_index.next
end

p password

