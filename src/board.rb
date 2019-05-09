require 'awesome_print'
class Board
  attr_accessor :matrix
  attr_accessor :x_dimension
  attr_accessor :y_dimension

  BOMB = :bomb
  DEFAULT_CELL_VALUE = 0

  def initialize(x, y)
    @x_dimension = x
    @y_dimension = y
    @matrix = create_empty_matrix
  end

  def cell_value(x, y)
    if out_of_bounds?(x, y)
      raise OutOfBoardBounds
    else
      matrix[x][y]
    end
  end

  def out_of_bounds?(x, y)
    !(matrix[x] && matrix[x][y])
  end

  def create_empty_matrix
    Array.new(x_dimension, DEFAULT_CELL_VALUE) { Array.new(y_dimension, DEFAULT_CELL_VALUE) }
  end

  def dimensions
    [x_dimension, y_dimension]
  end

  def cell_count
    x_dimension * y_dimension
  end

  def set_cell_as_bomb(x, y)
    matrix[x][y] = BOMB
  end

  def is_cell_empty?(x, y)
    matrix[x][y] == DEFAULT_CELL_VALUE
  end

  def is_cell_a_bomb?(x, y)
    matrix[x][y] == BOMB
  end

  def has_bombs?
    bomb_count > 0
  end

  def bomb_count
    matrix.reduce(0) { |_sum, row| row.select { |item| item == BOMB }.count }
  end

  def populate_adjacent_numbers
    matrix.each_with_index do |row, x|
      row.each do |y|
        # iterate through each cell
        next unless is_cell_a_bomb?(x, y)

        adjacent_cells(x, y).each do |pair|
          x, y = pair
          next if is_cell_a_bomb?(x, y)

          increase_adjacent_cells_count(x, y)
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
      [x - 1, x - 1], # a
      [x, x - 1], # b
      [x + 1, x - 1], # c
      [x + 1, x], # d
      [x + 1, x + 1], # e
      [x, x + 1], # f
      [x - 1, x + 1], # g
      [x - 1, x] # h
    ]
    cells.reject do |pair|
      x, y = pair
      out_of_bounds?(x, y)
    end
  end

  private

  def increase_adjacent_cells_count(x, y)
    matrix[x][y] = matrix[x][y] + 1
  end
end

class OutOfBoardBounds < StandardError; end
