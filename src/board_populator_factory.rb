Dir[File.join(__dir__, 'populator_strategies', '*.rb')].each do |file|
  require file
end

# This class is for populating the boards for the Minesweeper game.
# It has multiple strategies for populating the board with different amount
# of bombs. Each strategy is currently determined by the difficulty level.
# If one desires to, we can add a :heroic and :legendary difficulty level.
class BoardPopulatorFactory
  attr_accessor :board
  DEFAULT_DIFFICULTY_LEVEL = :easy

  def initialize(board)
    @board = board
  end

  def get_strategy_by_difficulty_level(
    difficulty_level = DEFAULT_DIFFICULTY_LEVEL
  )
    case difficulty_level
    when :easy
      EasyBoardPopulatorStrategy.new(board)
    when :medium
      MediumBoardPopulatorStrategy.new(board)
    when :hard
      HardBoardPopulatorStrategy.new(board)
    else
      raise UnknownDifficultyLevel
    end
  end
end

class UnknownDifficultyLevel < StandardError; end