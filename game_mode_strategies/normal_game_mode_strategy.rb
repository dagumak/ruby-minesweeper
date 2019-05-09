# Normal Game Mode 
# This version will only check the adjacent mines of (x, y) pair and return the number
# of bombs adjacent
class NormalGameModeStrategy
    attr_accessor :board
    
    def initialize(board)
        @board = board
    end

    def attempt(x, y)
        cell_value = board.cell_value(x, y)
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

class FoundBomb < StandardError; end
