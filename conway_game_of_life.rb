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
    choose_size
  end

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
      break if user_input.class == Integer && user_input.positive? && user_input <= 80
      begin
        raise ArgumentError
      rescue
        puts 'Invalid input'
        next
      end
    end
    @size = user_input
  end

  private



end

