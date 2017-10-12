class Board
  attr_reader :size

  def initialize
    @size = nil
    @values_to_display = []
  end

  def display_values(dead_or_alive)
    begin
      raise ArgumentError unless valid_values_to_display?(dead_or_alive)
    rescue
      puts "Invalid values to display!"
    end
    @values_to_display = dead_or_alive
    @size = Math::sqrt(@values_to_display.size)
    display_grid
  end

  private

# design the grid

  def display_grid
    top_line
    cells
  end

  def top_line
    puts "+" + "-" * (4 * (@size) - 1) + "+"
  end

  def convert_values_to_cells
    @values_to_display.map { |boolean| boolean == true ? "| X " : "|   " }
  end

  def break_in_multiple_lines
    convert_values_to_cells.each_slice(@size).map(&:to_a)
  end

  def cells
    break_in_multiple_lines.each do |line|
      puts line.join + "|"
      puts "+" + "-" * (4 * @size - 1) + "+"
    end
  end

  def valid_values_to_display?(values)
    values.class == Array && values.all? { |value| value == true || value == false }
  end
end
