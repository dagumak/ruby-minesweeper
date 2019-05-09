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
