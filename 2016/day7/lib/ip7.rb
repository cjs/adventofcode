class IPaddress
  attr_reader :address, :hypernet
  def initialize(address)
    @address = address.gsub(/\[\w+\]/, '|').split('|')
    @hypernet = address.scan(/\[(\w+)\]/).flatten
    @hypernet = nil if @hypernet.empty?
    if hypernet
      hypernet.each do |h|

      end
    end
  end

  def support_tls?
    self.hypernet.each { |h| return false if h.abba?  } if self.hypernet
    address.each {|a| return true if a.abba?}
    return false
  end

  def support_ssl?
    abas = []

    self.address.each do |a| 
      abas << a.find_aba unless a.find_aba.empty?
    end
    abas.flatten!
    return false if abas.empty? or self.hypernet.nil?
    babs = []
    hypernet.each do |h|
      babs << h.find_aba unless h.find_aba.empty?
    end
    babs.flatten!

    abas.each do |aba|
      return true if babs.include?(aba[1] + aba[0] + aba[1])
    end
    return false
  end
end

class String
  def abba?
    i = 0
    while i <= self.size - 4 do
      return true if self.slice(i,4).slice(0..1) == self.slice(i,4).slice(2..3).reverse and  self.slice(i,4).slice(0) != self.slice(i,4).slice(1)
      i = i + 1
    end
    return false
  end

  def find_aba
    s = self.split('')
    aba = []
    (1..s.size - 1 ).each do |i|
      s[i-1] == s[i+1] and s[i-1] != s[i] ? aba << self.slice(i-1..i+1) : aba
    end
    aba
  end
end
