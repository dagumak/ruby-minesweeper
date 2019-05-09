class Minesweeper
    attr_accessor :game_mode_strategy
    attr_accessor :board
    
    DIFFICULTY_LEVELS = [
        :easy,
        :medium,
        :hard
    ]

    GAME_STATUSES = [
        :in_progress,
        :victory,
        :loss
    ]

    GAME_MODES = [
        :simple,
        :normal
    ]

    def initialize(board_size, difficulty_level = :easy, game_mode = :simple)
        raise InvalidDifficultyLevel unless valid_difficulty_level?(difficulty_level)
        
        create_board(board_size, difficulty_level)
        set_game_mode_strategy(game_mode)
    end

    def display
        # loop through the matrix and print out true or false
    end

    def attempt(x, y)        
        # check if x and y is within the bounds of the matrix
        begin
            strategy.attempt(x, y)
        rescue BombFound
            puts "BOOOOM!"
            # set game status to :loss
        rescue OutOfBoardBounds
            puts "Invalid coordinate!"            
        end
        output_by_status
    end
    
    def status
       # TODO: Use AASM to manage the states 
    end

    private
    def create_board(board_size, difficulty_level)
        empty_board = Board.new(board_size)
        @board = populate_board_by_difficulty_level(empty_board, difficulty_level)
    end

    def populate_board_by_difficulty_level(board, difficulty_level)
        case difficulty_level
        when :easy
            strategy = EasyBoardPopulatorStrategy.new(board)
        when :hard
            strategy = HardBoardPopulatorStrategy.new(board)
        else 
            strategy = MediumBoardPopulatorStrategy.new(board)
        end
        strategy.populate
    end

    def output_by_status
        # get the status then 
        puts status
    end

    def set_game_mode_strategy(game_mode)
        case game_mode
        when :normal
            @game_mode_strategy = NormalGameModeStrategy.new(board)
        else
            @game_mode_strategy = GodGameModeStrategy.new(board)
        end
    end

    def valid_difficulty_level?(difficulty_level)
        DIFFICULTY_LEVELS.include? difficulty_level
    end
end

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

class EasyBoardPopulatorStrategy
    attr_accessor :board
    PERCENTAGE_OF_BOMBS = 0.10

    def initialize(board)
        @board = board
    end
        
    def populate
        # TODO: Check if board is empty before populating
        # populate the board with mines based on the difficulty
        return board
    end    
end

class MediumBoardPopulatorStrategy
    attr_accessor :board
    PERCENTAGE_OF_BOMBS = 0.50

    def initialize(board)
        @board = board
    end
        
    def populate
        # TODO: Check if board is empty before populating
        # populate the board with mines based on the difficulty
        return board
    end    
end

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




# Strategy Pattern?

# Normal Game Mode 
# This version will only check the adjacent mines of (x, y) pair and return the number
# of bombs adjacent
class NormalGameModeStrategy
    attr_accessor :board
    
    def initialize(board)
        @board = board
    end

    def attempt(x, y)
        cell_value = board.get_value(x, y)
        get_adjacent_mine_count(x, y)
    end

    def get_adjacent_mine_count(x, y)
        #        
        if revealed 
            return
        elsif bomb 
            raise BombFound
        elsif empty
            reveal all neighbors
            push neighbors onto stack
        elsif number
            reveal self
            return     
        end
    end
end

# God Game Mode Engine
# This version will disable bomb detonations eventually allowing you to always win.
class GodGameModeStrategy
    attr_accessor :board
    
    def initialize(board)
        @board = board
    end

    def attempt(x, y)

    end

    def get_adjacent_mine_count(x, y)
        if revealed 
            return
        elsif bomb 
            reveal self
        elsif empty
            reveal all neighbors
            push neighbors onto stack
        elsif number
            reveal self
            return     
        end

    end
end


class FoundBomb < StandardError; end
class OutOfBoardBounds < StandardError; end
class InvalidDifficultyLevel < StandardError; end




