require "#{__dir__}/base_board_populator_strategy"

class EasyBoardPopulatorStrategy < BaseBoardPopulatorStrategy
    PERCENTAGE_OF_BOMBS = 0.10

    def number_of_bombs
        (board.cell_count * PERCENTAGE_OF_BOMBS).ceil
    end
end
