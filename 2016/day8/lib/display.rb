class Pixel
  def initialize
    @state = false
  end

  def toggle
    @state = !@state 
  end

  def on
    @state = true
  end

  def off
    @state = false
  end

  def lit?
    @state
  end

  def to_s
    @state ? '#' : '.'
  end

  def inspect
    @state ? '#' : '.'
  end
end

class Display
  attr_reader :grid
  def initialize(x,y)
    @grid = []
    (y).times { @grid << Array.new(x) { Pixel.new } }
    @grid
  end

  def to_s
    output = ""
    @grid.each do |row| 
      row.each {|cell| output <<  cell.to_s }
      output << "\n"
    end
    output
  end

  def rect(a,b)
    @grid.slice(0,b).each do |row|
      row.slice(0, a).each do |p|
        p.on
      end
    end
  end

  def rotate_row(y, count)
    @grid[y].rotate!(- count)
    @grid
  end

  def rotate_column(x, count)
    tmpgrid = @grid.transpose
    tmpgrid[x].rotate!( - count )
    @grid = tmpgrid.transpose.dup
  end

  def count
    @grid.flatten.count { |c| c.lit? }
  end
end
