require 'colorize'
require 'awesome_print'
require 'aasm'
require "#{__dir__}/board"
require "#{__dir__}/game_mode_factory"
require "#{__dir__}/board_populator_factory"

# This class is for player interaction; the class displays the board to the
# player, understands the current game state (ex, in progress, loss, or win),
# and allows players to make a move. It's main function is to orchestrate other
# classes to make a functional game.
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

  def initialize(
    board_size, 
    difficulty_level = BoardPopulatorFactory::DEFAULT_DIFFICULTY_LEVEL, 
    game_mode = GameModeFactory::DEFAULT_MODE
  )
    create_board(board_size, difficulty_level)
    set_game_mode_strategy(game_mode)
  end

  def display(matrix = board.view_matrix)
    matrix.each_with_index do |row, index|
      formatted_row_data = row.collect do |value|
        case value
        when Board::NOT_SEEN
          "X".light_black
        when Board::BOMB
          "💣".red
        when 0
          "X".light_black
        when 1
          value.to_s.light_yellow
        else
          value.to_s.green
        end
      end
      puts formatted_row_data.join('  ')
    end
    nil
  end

  def display_with_map_hack
    display(board.data_matrix)
  end

  def attempt(x, y)
    # check if x and y is within the bounds of the matrix
    begin
      game_mode_strategy.attempt(x, y)
    rescue FoundBomb
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
    board_populator = BoardPopulatorFactory.new(empty_board)
    strategy = board_populator.get_strategy_by_difficulty_level(difficulty_level)
    @board = strategy.populate
  end

  def output_by_status
    # get the status then
    puts status
  end

  def set_game_mode_strategy(game_mode)
    @game_mode_strategy = GameModeFactory.new(board, game_mode).get_strategy
  end
end
