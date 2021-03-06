Dir[File.join(__dir__, 'populator_strategies', '*.rb')].each do |file|
  require file
end

# This class is factory collection of strategies available for bomb placement.
# Currently, we have 4 difficulties which is easy, medium, hard, and dagumak.
# There is a strategy class for each of the difficulties and each strategy
# understands how many bombs it has to place and sets it on the board.
class BoardPopulatorFactory
  attr_accessor :board
  DEFAULT_DIFFICULTY_LEVEL = :easy

  def initialize(board)
    @board = board
  end

  # rubocop:disable Metrics/MethodLength
  def strategy_by_difficulty_level(
    difficulty_level = DEFAULT_DIFFICULTY_LEVEL
  )
    case difficulty_level
    when :easy
      EasyBoardPopulatorStrategy.new(board)
    when :medium
      MediumBoardPopulatorStrategy.new(board)
    when :hard
      HardBoardPopulatorStrategy.new(board)
    when :dagumak
      DagumakBoardPopulatorStrategy.new(board)
    else
      raise UnknownDifficultyLevel
    end
  end
  # rubocop:enable Metrics/MethodLength
end

class UnknownDifficultyLevel < StandardError; end
