class Board
    attr_accessor :board

    def initialize(board_size)
        @board = create_empty_board(board_size, board_size)
    end

    def get_value(x, y)
        if out_of_bounds?(x, y)
            raise OutOfBoardBounds
        else
            return board[x][y]
        end
    end
    
    def out_of_bounds?(x, y)        
        # TODO: Implement if x and y is out of bounds
    end

    def create_empty_board(x, y)
        Array.new(x) { Array.new(y) }        
    end
end

class OutOfBoardBounds < StandardError; end
