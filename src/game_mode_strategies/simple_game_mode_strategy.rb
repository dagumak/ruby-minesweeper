# Simple Game Mode
# Unlike how the game behaves, this version will only reveal the empty cell
# when selected.
class SimpleGameModeStrategy
  attr_accessor :board
  attr_accessor :stack

  def initialize(board)
    @board = board
    @stack = []
  end

  def attempt(x, y)
    pair = coordinates_to_indices(x, y)
    board.mark_as_seen!(*pair)
    raise FoundBomb if board.cell_a_bomb?(*pair)
    board.cell_value(*pair)
  end

  # We have to convert "coordinates" to "indices". Board Class takes everything as
  # an index and starts from zero.
  def coordinates_to_indices(x, y)
    [x - 1, y - 1]
  end

  def won?
    board.unseen_cell_count == board.bomb_count
  end
end

class FoundBomb < StandardError; end
