class Room
  attr_reader :name, :sector
  def initialize(room)
    _, @name, @sector, @checksum = room.match('(\S+)-(\d+)\[(\D+)\]').to_a
    @sector = @sector.to_i
  end

  def checksum
    freq = ('a'..'z').to_a.product([0]).to_h
    self.name.tr('-','').each_char {|c| freq[c] += 1}
    freq.to_a.sort_by {|char, count| [-count, char]}.take(5).reduce(''){|checksum, c| checksum.concat(c[0])}
  end

  def valid?
    self.checksum == @checksum
  end
 
  def decrypt
    self.name.rot(self.sector).tr('-', ' ')
  end

end
class String
  def rot(num = 13)
    return self.split("").collect { |ch|
      if /^[a-z]$/ === ch
        ((ch.ord + num - 'a'.ord) % 26 + 'a'.ord).chr
      elsif /^[A-Z]$/ === ch
        ((ch.ord + num - 'A'.ord) % 26 + 'A'.ord).chr
      else
        ch
      end
    }.join("")
  end
end

