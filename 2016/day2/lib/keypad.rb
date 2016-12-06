# Class to represent a Button
class Button
  attr_reader :row, :column
  attr_accessor :up, :down, :right, :left, :value

  # Button#initialize(x,y, value)
  def initialize(row, column, value)
    @row, @column = row, column
    @value = value
  end
end

# Class to represent the Keypad
#
class Keypad
  attr_accessor :rows, :columns
  def initialize(rows, values)
    @grid = Array.new(rows.count) { Array.new(rows.count, nil) }
    row_index = 0
    rows.each do |rowsize|
      upper_bound = (rows.count + rowsize)/2 - 1
      lower_bound = rows.count - upper_bound - 1
      (lower_bound..upper_bound).to_a.each do |col|
        @grid[row_index][col] = Button.new(row_index, col, values.pop)
      end
      row_index += 1
    end
    link_grid
  end

  def link_grid
    @grid.each do |grid_row|
      grid_row.each do |button|
        next if button.nil?
        row, col = button.row, button.column
        button.up = @grid[row - 1][col] if row.between?(1, @grid.count- 1)
        button.down = @grid[row + 1][col] if row.between?(0, @grid.count - 2)
        button.left = @grid[row][col - 1] if col.between?(1, @grid.count - 1)
        button.right = @grid[row][col + 1] if col.between?(0, @grid.count - 2)
      end
    end
  end

  def [](row, column)
    @grid[row][column]
  end
end

class Navigate
  attr_reader :current, :start
  def initialize(start)
    @start = start
    @current = start
  end

  def find_button(steps)
    current = @current
    steps.each do |step|
      case step
      when "U"
        current = current.up unless current.up.nil?
      when "D"
        current = current.down unless current.down.nil?
      when "L"
        current = current.left unless current.left.nil?
      when "R"
        current = current.right unless current.right.nil?
      end
    end
    @current = current
  end
end

