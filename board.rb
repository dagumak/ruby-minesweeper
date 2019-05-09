class Board
    attr_accessor :board

    BOMB = :bomb

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
       !(board[x] && board[x][y])
    end

    def create_empty_board(x, y)
        Array.new(x, 0) { Array.new(y, 0) }
    end

    def dimensions
        board_size, board_size
    end

    def cell_count
        x, y = dimensions
        x * y
    end

    def set_cell_as_bomb(x, y)
        board[x][y] = BOMB
    end

    def is_cell_empty?(x, y)
        board[x][y] == 0
    end

    def is_cell_a_bomb?(x, y)
        board[x][y] == BOMB
    end

    def has_bombs?
        bomb_count == 0 
    end

    def bomb_count
        board.each do |row|
            row.each do |column|
                puts column  
            end
        end
    end

    def populate_adjacent_numbers
        board.each do |x|
            row.each do |y|
                # iterate through each cell
                if is_cell_a_bomb?(x, y)
                    adjacent_cells(x, y).each do |pair|
                        x, y = pair
                        increase_adjacent_cells_count(x, y)
                    end
                end
            end
        end
        
    end

    # This is the position of the coordinates in the array.
    #
    # [a, b, c, d, e, f, g, h]
    #
    # | a | b | c |
    # | h | 0 | d |
    # | g | f | e |

    #        y-1
    #         |
    # x-1 <-- 0 --> x+1
    #         |
    #        y+1
    
    # TODO: Add unit tests for this
    def adjacent_cells(x, y)
        cells = [
            [x-1, x-1],     # a
            [x, x-1],       # b
            [x+1, x-1],     # c
            [x+1, x],       # d
            [x+1, x+1],     # e
            [x, x+1],       # f
            [x-1, x+1],     # g
            [x-1, x],       # h
        ]
        cells.select do |pair| 
            x, y = pair
            out_of_bounds?(x, y)
        end
    end

    private
    def increase_adjacent_cells_count(x, y)
        return if is_cell_a_bomb?(x, y)
        board[x][y]++
    end
end

class OutOfBoardBounds < StandardError; end
