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

require_relative 'board'
require_relative 'engine'

class GameOfLife

  def initialize
    @size = nil
    run
  end

  private

  def run
    greeting
    set_up_size
    set_up_alive_cells
    puts "Here is the initial board..."
    puts "Now, Let's live and die!"
    display_initial_board
    sleep(1)
    Engine.new(@initial_values, @size)
  end

  def greeting
    puts "Welcome in the Conway's Game of Life"
  end

  def set_up_size(input: $stdin)
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

  def set_up_alive_cells
    puts "Please, choose which cells are alive at the beginning of the game"
    puts "Each cell is associated with a number from 1 to #{@size * @size}"
    @live_cells = []
    loop do
      puts "Enter a number :"
      choice = gets.chomp
      if valid_choice?(choice)
         @live_cells << choice.to_i - 1 #to be able to associate a choice with an index in the datastructure
        puts 'OK'
        puts "Your choices : #{@live_cells.map { |choice| choice + 1}.map(&:to_s).join(",")}."
        sleep(0.5)
      else
        next
      end
      puts "Press (s) if you want to stop."
      puts "Press enter to continue your choice."
      press = gets.chomp
      break if end_of_choice?(press)
    end
    @live_cells
  end

  def valid_choice?(choice)
    if choice.chars.all? { |char| char.match(/[0-9]/) }
      if choice.to_i == 0
        puts "Invalid choice"
        return false
      elsif @live_cells.include?(choice.to_i - 1)
        puts "You have already made this choice!"
        return false
      else
        return true
      end
    end
    puts 'Invalid choice'
  end

  def end_of_choice?(choice)
    if choice.match(/s/i)
      return true
    else
      return false
    end
  end

  def set_initial_values
    @initial_values = Array.new(@size * @size) { false }
    @live_cells.each { |index| @initial_values[index] = true }
    p @initial_values
  end

  def display_initial_board
    Board.new.display_values(set_initial_values)
  end
end

#Board.new.display_values([true, true, false, false, true, true, false, true, true, true, false, false, true, true, true, false, true, false, true, true, true, false, false, false, true])

GameOfLife.new
