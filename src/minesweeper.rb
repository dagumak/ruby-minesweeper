require 'aasm'
require "#{__dir__}/board"
require "#{__dir__}/game_mode"
require "#{__dir__}/board_populator"

class Minesweeper
  include AASM

  attr_accessor :game_mode_strategy
  attr_accessor :board

  aasm do
    state :in_progress, initial: true

    event :win do
      transitions from: :in_progress, to: :victory
    end

    event :lose do
      transitions from: :in_progress, to: :loss
    end
  end

  def initialize(board_size, difficulty_level = BoardPopulator::DEFAULT_DIFFICULTY_LEVEL, game_mode = GameMode::DEFAULT_MODE)
    create_board(board_size, difficulty_level)
    set_game_mode_strategy(game_mode)
  end

  def display
    # loop through the matrix and print out true or false
  end

  def attempt(x, y)
    # check if x and y is within the bounds of the matrix
    begin
      strategy.attempt(x, y)
    rescue BombFound
      puts 'BOOOOM!'
    # set game status to :loss
    rescue OutOfBoardBounds
      puts 'Invalid coordinate!'
    end
    output_by_status
  end

  def status
    # TODO: Use AASM to manage the states
  end

  private

  def create_board(board_size, difficulty_level)
    empty_board = Board.new(board_size, board_size)
    board_populator = BoardPopulator.new(empty_board)
    @board = board_populator.populate_by_difficulty_level(difficulty_level)
  end

  def output_by_status
    # get the status then
    puts status
  end

  def set_game_mode_strategy(game_mode)
    @game_mode_strategy = GameMode.new(board, game_mode)
  end
end
