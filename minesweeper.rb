require "board.rb"
require 'game_mode'
require 'board_populator'

class Minesweeper
    attr_accessor :game_mode_strategy
    attr_accessor :board
    
    # TODO: Use AASM to manage the states 
    GAME_STATUSES = [
        :in_progress,
        :victory,
        :loss
    ]

    def initialize(board_size, difficulty_level = nil, game_mode = nil)        
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
        empty_board = Board.new(board_size, board_size)
        board_populator = BoardPopulator.new(empty_board)
        @board = board_populator.populate_by_difficulty_level(difficulty_level)
    end

    def output_by_status
        # get the status then 
        puts status
    end

    def set_game_mode_strategy(game_mode)
        @game_mode_strategy = GameMode.new(board, game_mode)
    end
end
