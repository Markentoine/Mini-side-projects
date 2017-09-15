require 'simplecov'
SimpleCov.start

require 'stringio'

require 'minitest/autorun'

require_relative 'conway_game_of_life'

module IoTestHelpers
  def self.multiple_input_stdin(*inputs)
    io = StringIO.new
    inputs.flatten.each { |str| io.puts(str) }
    io.rewind

    actual_stdin, $stdin = $stdin, io
    yield
  ensure
    $stdin = actual_stdin
  end
end

# test of the Board class
class BoardTest < Minitest::Test
  def setup
    $stdout = StringIO.new
    $stdin = StringIO.new("80")
    @board = Board.new
  end

  def test_instantiation
    assert_equal(Board, @board.class)
  end

  def test_correct_input
    assert_equal(80, @board.size)
  end

  def test_multiple_input_with_string_one
    $stderr = StringIO.new
    board = nil
    IoTestHelpers.multiple_input_stdin(["string", "80"]) { board = Board.new } #enter multiple inputs
    assert_match(/Invalid/, $stdout.string) #check if an error has been rescued
    assert_equal(80, board.size) #check if the object has been created with the correct input value
  end

  def test_multiple_input_with_negative_one
    $stderr = StringIO.new
    board = nil
    IoTestHelpers.multiple_input_stdin(["-1", "80"]) { board = Board.new }
    assert_match(/Invalid/, $stdout.string)
    assert_equal(80, board.size)
  end

  def test_multiple_input_with_out_of_limit_one
    $stderr = StringIO.new
    board = nil
    IoTestHelpers.multiple_input_stdin(["100", "80"]) { board = Board.new }
    assert_match(/Invalid/, $stdout.string)
    assert_equal(80, board.size)
  end

  def test_display_choose_size
    assert_equal("Please, choose the size of the board? (max : 80)\n", $stdout.string)
  end

  def teardown
    $stdout = STDOUT
    $stdin = STDIN
  end
end
