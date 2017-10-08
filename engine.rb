require_relative 'board'

class Engine
  def initialize(initial_values, size)
    @initial_state = initial_values
    @current_state = @initial_state
    @size = size
    define_frontiers
    run
  end

  private

  def run
    loop do
      clear
      next_state =  process_birth_and_death(@current_state)
      break unless next_state.any? #taking advantage of the bare #any? return : any? truthy?
      Board.new.display_values(next_state)
      sleep(0.5)
      @current_state = next_state
    end
  end

  def clear
    system 'clear'
  end

  def process_birth_and_death(state)
    @current_association = associate_a_number_to_each_cell(state)
    next_association = @current_association.clone
    @current_association.each_key do |num|
      if will_die?(num)
        next_association[num] = false
      elsif will_born?(num)
        next_association[num] = true
      end
    end
    next_association.values
  end

  def will_die?(num)
    count_alive_neighbors(num) < 2 || count_alive_neighbors(num) > 3
  end

  def will_born?(num)
    count_alive_neighbors(num) == 3
  end

  def count_alive_neighbors(num)
    neighbors = all_neighbors(num)
    selection = @current_association.select { |num, _| neighbors.include?(num) }
    selection.count { |_, alive| alive == true }
  end

  def all_neighbors(num)
    position = position_of_number(num)
    neighbors = []
    if position == :center
      neighbors = neighbors_for_center(num)
    elsif [:upleft, :upright, :lowleft, :lowright].include?(position)
      neighbors = neighbors_for_corners(num, position)
    else
      neighbors = neighbors_for_borders(num, position)
    end
    neighbors
  end

  def neighbors_for_center(num)
    neighbors = []
    3.times do |n|
      neighbors << ((num - @size) - 1) + n
      neighbors << ((num + @size) - 1) + n
    end
    neighbors << (num - 1) << (num + 1)
    neighbors
  end

  def neighbors_for_corners(num, corner)
    case corner
    when :upleft then [(num + 1), (num + @size), (num + @size + 1)]
    when :upright then [(num - 1), (num + @size), (num + @size - 1)]
    when :lowleft then [(num - @size), (num - @size + 1), (num + 1)]
    when :lowright then [(num - @size - 1), (num - @size), (num - 1)]
    end
  end

  def neighbors_for_borders(num, border)
    case border
    when :top_frontier then [(num - 1), (num + 1), (num + @size - 1), (num + @size), (num + @size + 1)]
    when :right_frontier then [(num - @size), (num - @size - 1), (num - 1), (num + @size - 1), (num + @size)]
    when :bottom_frontier then [(num - 1), (num + 1), (num - @size - 1), (num - @size), (num - @size + 1)]
    when :left_frontier then [(num - 1), (num - @size), (num - @size + 1), (num + @size), (num + @size + 1)]
    end
  end

  def define_frontiers
    @rows = define_rows
    @columns = define_columns
    @top_frontier = @rows.first
    @bottom_frontier = @rows.last
    @left_frontier = @columns.first
    @right_frontier =  @columns.last
  end

  def position_of_number(num)
    if is_at_frontier?(num)
      if is_in_a_corner?(num)
        return which_corner?(num)
      else
        return which_frontier?(num)
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
    @top_frontier.include?(num) && @left_frontier.include?(num)
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
