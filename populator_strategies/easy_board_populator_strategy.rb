class EasyBoardPopulatorStrategy
    attr_accessor :board
    PERCENTAGE_OF_BOMBS = 0.10

    def initialize(board)
        @board = board
    end
        
    def populate
        raise BoardAlreadyPopulated if board.has_bombs?
        number_of_bombs = board.cell_count * PERCENTAGE_OF_BOMBS
        x_dimension, y_dimension = board.dimensions
        
        while number_of_bombs != board.bomb_count do        
            x = rand(x_dimension)
            y = rand(y_dimension)
            board.set_cell_as_bomb(x, y) unless board.is_cell_a_bomb?(x, y)
        end

        board.populate_adjacent_numbers
        
        return board
    end    
end

class BoardAlreadyPopulated < StandardError; end
