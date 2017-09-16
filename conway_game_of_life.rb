# Implementation of the Conway Game of Life
# objects :
# => Board to display the cells
#   => user can choice the size
# => a datastructure to store the state of the cells
# => cells (alive or dead)
# population : setup (user choice or randomly); the
# size of the population depends on the size of the
# board chosen by the user
# max display = 80 * 80 cells

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

class GameOfLife

  def initialize
    @size = nil
    choose_size
  end

  private

  def choose_size(input: $stdin)
    user_input = nil
    loop do
      begin
        puts 'Please, choose the size of the board? (max : 80)'
        user_input = input.gets.chomp
        if user_input =~ /[^0-9]/
          raise ArgumentError
        end
      rescue
        puts 'Invalid input'
        next
      end
      user_input = user_input.to_i
      break if user_input.positive? && user_input <= 80
      begin
        raise ArgumentError
      rescue
        puts 'Invalid input'
        next
      end
    end
    @size = user_input
  end

end

Board.new.display_values([true, true, false, false, true, true, false, true, true, true, false, false, true, true, true, false, true, false, true, true, true, false, false, false, true])

