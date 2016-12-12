class String
  def decompress
    s = self.dup
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

  def d2length
    i = 0
    count = 0
    re =  /\((\d+)x(\d+)\)/
    until i == self.size do
      a, m, b = self[i..-1].partition(re)
      count += a.size
      i = i + a.size
      unless m.empty?
        chars, repeat = m.match(re).captures.collect {|s| Integer(s)}
        i = i + chars + m.size
        # My original naive solution was to evaluate the expanded string. That's dumb
        # Better to find the length of the string and multiply
        count = count + repeat * b[0,chars].d2length unless m.empty?
      end
    end
  count
  end
end

