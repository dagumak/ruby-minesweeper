require "#{__dir__}/base_board_populator_strategy"

# This strategy is based of the BaseBoardPopulatorStrategy, and
# it's only responsibility is to determine the amount of bombs
# required.
class HardBoardPopulatorStrategy < BaseBoardPopulatorStrategy
  PERCENTAGE_OF_BOMBS = 0.90

  def number_of_bombs
    (board.cell_count * PERCENTAGE_OF_BOMBS).ceil
  end
end
