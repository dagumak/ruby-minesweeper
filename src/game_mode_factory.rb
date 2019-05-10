Dir[File.join(__dir__, 'game_mode_strategies', '*.rb')].each do |file|
  require file
end

# This class is factory collection of game modes. A game mode determines how the
# Minesweeper game should react when you select a cell to reveal and the winning
# condition. For example, in `SimpleGameModeStrategy`, when you select a cell
# that is empty then it just reveals that cell. However, in
# `NormalGameModeStrategy` when you select an empty cell, then it proceeds to
# reveal all empty cells connected until it reaches a number. Lastly, in
# `GodGameModeStrategy` when you select a cell and it's a bomb, nothing happens
# because you're in god mode.
class GameModeFactory
  attr_accessor :board
  attr_accessor :game_mode

  DEFAULT_MODE = :normal

  def initialize(board, game_mode = DEFAULT_MODE)
    @board = board
    @game_mode = game_mode
  end

  def strategy
    case game_mode
    when :simple
      @game_mode_strategy = SimpleGameModeStrategy.new(board)
    when :normal
      @game_mode_strategy = NormalGameModeStrategy.new(board)
    when :god
      @game_mode_strategy = GodGameModeStrategy.new(board)
    else
      raise UnknownGameMode
    end
  end
end

class UnknownGameMode < StandardError; end
