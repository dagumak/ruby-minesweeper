require "#{__dir__}/base_board_populator_strategy"

class MediumBoardPopulatorStrategy < BaseBoardPopulatorStrategy
    PERCENTAGE_OF_BOMBS = 0.50

    def number_of_bombs
        board.cell_count * PERCENTAGE_OF_BOMBS
    end
end
