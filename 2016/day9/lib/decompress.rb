class String
  def decompress
    s = self
    debug = false
    p "debugging #{s}" if debug
    re =  /\((\d+)x(\d+)\)/
    ds = ''
    until  s.empty? do
      output, marker, rem = s.partition(re)
      p "output: #{output} marker: #{marker} rem: #{rem}"if debug
      ds << output unless output.empty?
      unless marker.empty?
        chars, repeat = marker.match(re).captures
        chunk = rem[0, Integer(chars)]
        p "chunk: #{chunk}" if debug
        Integer(repeat).times { ds << chunk }
        rem = rem[Integer(chars)..-1]
      end
      s.replace(rem)
      p "End Loop: #{s.inspect}" if debug
    end
    ds
  end
end
