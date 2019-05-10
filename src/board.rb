# This class is used to manage the Minesweeper data_matrix.
# Setting the bombs are decided by the caller, but this class knows how to
# fill the data_matrix with the proper bomb-adjacent-numbers
# There are 2 matrices: Data and View
# The data one is where all the adjacent numbers and bombs reside whereas the 
# view just represents the user's interaction. This doubles the space complexity
# in favor of separation of responsibilities.
class Board
  attr_accessor :data_matrix
  attr_accessor :view_matrix
  attr_accessor :x_dimension
  attr_accessor :y_dimension

  BOMB = :bomb
  DEFAULT_CELL_VALUE = 0

  def initialize(x_dimension, y_dimension)
    @x_dimension = x_dimension
    @y_dimension = y_dimension
    @data_matrix = create_empty_matrix
    @view_matrix = create_empty_matrix
  end

  def cell_value(i_index, j_index)
    raise OutOfBoardBounds if out_of_bounds?(i_index, j_index)

    data_matrix[i_index][j_index]
  end

  def out_of_bounds?(i_index, j_index)
    return true if i_index.nil? || j_index.nil?
    return true if i_index < 0 || j_index < 0

    !(data_matrix[i_index] && data_matrix[i_index][j_index])
  end

  def create_empty_matrix
    Array.new(x_dimension, DEFAULT_CELL_VALUE) do
      Array.new(y_dimension, DEFAULT_CELL_VALUE)
    end
  end

  def dimensions
    [x_dimension, y_dimension]
  end

  def cell_count
    x_dimension * y_dimension
  end

  def set_cell_as_bomb(i_index, j_index)
    data_matrix[i_index][j_index] = BOMB
  end

  def cell_a_bomb?(i_index, j_index)
    data_matrix[i_index][j_index] == BOMB
  end

  def bombs?
    bomb_count > 0
  end

  def bomb_count
    data_matrix.reduce(0) { |sum, row| sum + row.select { |item| item == BOMB }.count }
  end

  def populate_adjacent_numbers
    data_matrix.each_with_index do |row, i_index|
      row.each_with_index do |cell_value, j_index|
        next if out_of_bounds?(i_index, j_index)
        next unless cell_a_bomb?(i_index, j_index)

        adjacent_cells(i_index, j_index).each do |pair|
          i_index, j_index = pair
          next if cell_a_bomb?(i_index, j_index)

          increase_adjacent_cells_count(i_index, j_index)
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

  #           j_index-1
  #               |
  # i_index-1 <-- 0 --> i_index+1
  #               |
  #           j_index+1

  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Metrics/AbcSize
  def adjacent_cells(i_index, j_index)
    return [] if out_of_bounds?(i_index, j_index)

    cells = [
      [i_index - 1, j_index - 1], # a
      [i_index - 1, j_index], # b
      [i_index - 1, j_index + 1], # c
      [i_index, j_index + 1], # d
      [i_index + 1, j_index + 1], # e
      [i_index + 1, j_index], # f
      [i_index + 1, j_index - 1], # g
      [i_index, j_index - 1] # h
    ]
    cells.reject do |pair|
      i_index, j_index = pair
      out_of_bounds?(i_index, j_index)
    end
  end
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Metrics/AbcSize

  private

  def increase_adjacent_cells_count(i_index, j_index)
    data_matrix[i_index][j_index] = data_matrix[i_index][j_index] + 1
  end
end

class OutOfBoardBounds < StandardError; end
