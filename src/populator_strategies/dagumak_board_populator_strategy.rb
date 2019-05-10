# This strategy is a basic example of manually placing bombs.
# It populates bombs placed to form DMAK.
class DagumakBoardPopulatorStrategy
  attr_accessor :board

  def initialize(board)
    @board = board
  end

  # rubocop:disable Metrics/MethodLength
  def populate
    raise BoardAlreadyPopulated if board.bombs?
    raise BoardDimensionTooSmall if board.cell_count < 154

    # D
    board.set_cell_as_bomb(1, 1)
    board.set_cell_as_bomb(2, 1)
    board.set_cell_as_bomb(3, 1)
    board.set_cell_as_bomb(4, 1)
    board.set_cell_as_bomb(5, 1)

    board.set_cell_as_bomb(1, 2)
    board.set_cell_as_bomb(1, 3)
    board.set_cell_as_bomb(2, 4)
    board.set_cell_as_bomb(3, 4)
    board.set_cell_as_bomb(4, 4)
    board.set_cell_as_bomb(5, 3)
    board.set_cell_as_bomb(5, 2)

    # M
    board.set_cell_as_bomb(1, 6)
    board.set_cell_as_bomb(2, 6)
    board.set_cell_as_bomb(3, 6)
    board.set_cell_as_bomb(4, 6)
    board.set_cell_as_bomb(5, 6)

    board.set_cell_as_bomb(1, 10)
    board.set_cell_as_bomb(2, 10)
    board.set_cell_as_bomb(3, 10)
    board.set_cell_as_bomb(4, 10)
    board.set_cell_as_bomb(5, 10)

    board.set_cell_as_bomb(2, 7)
    board.set_cell_as_bomb(3, 8)
    board.set_cell_as_bomb(2, 9)

    # A
    board.set_cell_as_bomb(2, 12)
    board.set_cell_as_bomb(3, 12)
    board.set_cell_as_bomb(4, 12)
    board.set_cell_as_bomb(5, 12)

    board.set_cell_as_bomb(2, 15)
    board.set_cell_as_bomb(3, 15)
    board.set_cell_as_bomb(4, 15)
    board.set_cell_as_bomb(5, 15)

    board.set_cell_as_bomb(1, 13)
    board.set_cell_as_bomb(1, 14)
    board.set_cell_as_bomb(3, 13)
    board.set_cell_as_bomb(3, 14)

    # K
    board.set_cell_as_bomb(1, 17)
    board.set_cell_as_bomb(2, 17)
    board.set_cell_as_bomb(3, 17)
    board.set_cell_as_bomb(4, 17)
    board.set_cell_as_bomb(5, 17)

    board.set_cell_as_bomb(1, 20)
    board.set_cell_as_bomb(2, 19)
    board.set_cell_as_bomb(3, 18)
    board.set_cell_as_bomb(4, 19)
    board.set_cell_as_bomb(5, 20)

    board.populate_adjacent_numbers
    board
  end
  # rubocop:enable Metrics/MethodLength
end

class BoardAlreadyPopulated < StandardError; end
class BoardDimensionTooSmall < StandardError; end
