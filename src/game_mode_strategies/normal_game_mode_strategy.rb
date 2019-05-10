# Normal Game Mode
# This version will reveal all neighboring empty cells until they find a number 
# when an empty cell is selected.
class NormalGameModeStrategy
  attr_accessor :board
  attr_accessor :stack

  def initialize(board)
    @board = board
    @stack = []
  end

  def attempt(x, y)
    pair = coordinates_to_indices(x, y)
    stack.push(pair)
    process_pair(stack.pop) while stack.length.nonzero?
    cell_value = board.cell_value(*pair)
    puts cell_value
    cell_value
  end

  def process_pair(index_pair)
    board.mark_as_seen!(*index_pair)
    
    if board.cell_a_bomb?(*index_pair)
      puts 'BOOOOM!' 
      raise FoundBomb
    end

    cell_value = board.cell_value(*index_pair)
    if cell_value.zero?
      board.adjacent_cells(*index_pair).each do |pair|
        stack.push(pair) if board.not_seen?(*pair)
      end
    end
  end

  # We have to convert "coordinates" to "indices". Board Class takes everything as
  # an index and starts from zero.
  def coordinates_to_indices(x, y)
    [x - 1, y - 1]
  end
end

class FoundBomb < StandardError; end
