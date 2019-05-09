class HardBoardPopulatorStrategy
    attr_accessor :board
    PERCENTAGE_OF_BOMBS = 0.90

    def initialize(board)
        @board = board
    end
        
    def populate
        # TODO: Check if board is empty before populating
        # populate the board with mines based on the difficulty
        return board
    end    
end
