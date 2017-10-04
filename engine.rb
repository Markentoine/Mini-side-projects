require_relative 'board'

class Engine
  def initialize(initial_values, size)
    @initial_state = initial_values
    @size = size
    define_frontiers
    run
  end

  private

  def run
    current_state = @initial_state
    loop do
      clear
      next_state =  birth_and_death(current_state)
      break if next_state.all? { |value| value == false}
      Board.new.display_values(next_state)
    end
  end

  def birth_and_death(state)
    association = associate_a_number_to_each_cell(state)
    association.each_key do |number|
      if will_die?(number)
        association[number] = false
      elsif will_live?(number)
        association(number) = true
      end
    end
    association.values
  end

  def will_die?(number)

  end

  def will_live?(number)

  end

  def retrieve_neighbors(number)
    position = position_of_number(number)
    neighbors = []
    if position == :center
      neighbors = neighbors_for_center(number)
    end
  end

  def neighbors_for_center(number)
    neighbors = []
    3.times do |n|
      neighbors << (number - (@size - 1)) + n
      neighbors << (number + (@size - 1)) + n
    end
    neighbors << number - 1 << number + 1
    neighbors
  end

  def define_frontiers
    @rows = define_rows
    @columns = define_columns
    @top_frontier = @rows.first
    @bottom_frontier = @rows.last
    @left_frontier = @columns.first
    @right_frontier =  @columns.last
  end

  def position_of_number(number)
    if is_at_frontier?(number)
      if is_in_a_corner?(number)
        return which_corner?(number)
      else
        return which_frontier?(number)
      end
    else
      :center
    end
  end

  def is_in_a_corner?(num)
    is_in_upper_left_corner?(num) || is_in_upper_right_corner?(num) || is_in_lower_left_corner?(num) || is_in_lower_right_corner?(num)
  end

  def which_corner?(num)
   if is_in_upper_left_corner?(num)
     :upleft
   elsif is_in_upper_right_corner?(num)
     :upright
   elsif is_in_lower_left_corner?(num)
     :lowleft
   elsif is_in_lower_right_corner?(num)
     :lowright
   end
  end

  def which_frontier?(num)
    if is_in_top_border?(num)
      :top_frontier
    elsif is_in_bottom_border?(num)
      :bottom_frontier
    elsif is_in_left_border?(num)
      :left_frontier
    elsif is_in_right_border?(num)
      :right_frontier
    end
  end

  def is_at_frontier?(num)
    @top_frontier.include?(num) || @bottom_frontier.include?(num) || @left_frontier.include?(num) || @right_frontier.include?(num)
  end

  def is_in_center?(num)
    !is_at_frontier?(num)
  end

  def is_in_upper_left_corner?(num)
    @top_frontier.include?(num) && @lef_frontier.include?(num)
  end

  def is_in_upper_right_corner?(num)
    @top_frontier.include?(num) && @right_frontier.include?(num)
  end

  def is_in_lower_left_corner?(num)
    @bottom_frontier.include?(num) && @left_frontier.include?(num)
  end

  def is_in_lower_right_corner?(num)
    @bottom_frontier.include?(num) && @right_frontier.include?(num)
  end

  def is_in_top_border?(num)
    @top_frontier.include?(num)
  end

  def is_in_bottom_border?(num)
    @bottom_frontier.include?(num)
  end

  def is_in_left_border?(num)
    @left_frontier.include?(num)
  end

  def is_in_right_border?(num)
    @right_frontier.include?(num)
  end

  def associate_a_number_to_each_cell(values)
    (1..(@size * @size)).to_a.zip(values).to_h
  end

  def define_rows
    (1..(@size * @size)).to_a.each_slice(@size).map(&:to_a)
  end

  def define_columns
    define_rows.transpose
  end
end
