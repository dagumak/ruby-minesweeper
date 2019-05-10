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
    i_index, j_index = index_pair
    board.mark_as_seen!(i_index, j_index)
    
    if board.cell_a_bomb?(i_index, j_index)
      puts 'BOOOOM!' 
      raise FoundBomb
    end

    cell_value = board.cell_value(i_index, j_index)
    if cell_value.zero?
      board.adjacent_cells(i_index, j_index).each do |pair|
        i_index, j_index = pair
        stack.push(pair) if board.not_seen?(i_index, j_index)
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
