class BaseBoardPopulatorStrategy
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  def number_of_bombs
    10
  end

  def populate
    raise BoardAlreadyPopulated if board.has_bombs?

    x_dimension, y_dimension = board.dimensions

    while number_of_bombs != board.bomb_count
      x = rand(x_dimension)
      y = rand(y_dimension)
      board.set_cell_as_bomb(x, y) unless board.is_cell_a_bomb?(x, y)
    end

    board.populate_adjacent_numbers

    board
  end
end

class BoardAlreadyPopulated < StandardError; end
