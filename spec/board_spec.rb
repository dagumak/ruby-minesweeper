require "#{__dir__}/../src/board"

RSpec.describe Board do
    context "#dimensions" do
        it "should return the dimensions for a board" do
            x_dimension = 1
            y_dimension = 2
            board = Board.new(x_dimension, y_dimension)
            expect(board.dimensions).to eq([x_dimension, y_dimension])
        end
    end
    
    context "#out_of_bounds?" do
        it "should return true when given indices outside of the data matrix" do
            x_dimension = 1
            y_dimension = 2
            board = Board.new(x_dimension, y_dimension)
            expect(board.out_of_bounds?(x_dimension+1, y_dimension)).to be_truthy
        end
        it "should return true when given negative indices outside of the data matrix" do
            x_dimension = 1
            y_dimension = 2
            board = Board.new(x_dimension, y_dimension)
            expect(board.out_of_bounds?(-1, -1)).to be_truthy
        end
       
        it "should return false when given indices inside of the data matrix" do
            x_dimension = 1
            y_dimension = 2
            board = Board.new(x_dimension, y_dimension)
            expect(board.out_of_bounds?(x_dimension-1, y_dimension-1)).to be_falsey
        end
    end
    
    context "#cell_count?" do
        it "should return true when given indices out side of the data matrix" do
            x_dimension = 1
            y_dimension = 2
            board = Board.new(x_dimension, y_dimension)
            expect(board.cell_count).to eq(x_dimension*y_dimension)
        end
    end
    
    context "#cell_value" do
        it "should return the value based on the indices given" do
            x_dimension = 2
            y_dimension = 2
            board = Board.new(2, 2)
            board.set_cell_as_bomb(0,0)
            board.populate_adjacent_numbers
            expect(board.cell_value(1, 1)).to eq(1)
        end

        it "should return the bomb in the cell value" do
            board = Board.new(1, 2)
            board.set_cell_as_bomb(0,0)
            expect(board.cell_value(0, 0)).to eq(Board::BOMB)
        end

        it "should raise 'OutOfBoardBounds' if attempting to get a value out side of the board" do
            board = Board.new(1, 2)
            expect {
                board.cell_value(10, 10)
            }.to raise_error(OutOfBoardBounds)
        end
    end
    
    context "#adjacent_cells" do
        it "should return an array of adjacent cells that are not out of bounds in the negative region" do
            x_dimension = 10
            y_dimension = 10
            board = Board.new(x_dimension, y_dimension)
            expect(board.adjacent_cells(0, 0)).to(
                eq([
                    [0,1],
                    [1,1],
                    [1,0]
                ])
            )
        end

        it "should return an array of adjacent cells that are not out of bounds positive region" do
            x_dimension = 10
            y_dimension = 10
            board = Board.new(x_dimension, y_dimension)
            expect(board.adjacent_cells(9, 9)).to(
                eq([
                    [8,8],
                    [8,9],
                    [9,8]
                ])
            )
        end

        it "should return nothing if the indice given is out of bounds" do
            x_dimension = 10
            y_dimension = 10
            board = Board.new(x_dimension, y_dimension)
            expect(board.adjacent_cells(10, 10)).to(
                eq([])
            )
        end
    end
    
    context "#set_cell_as_bomb" do
        it "should set a bomb at the given index position" do
            expected = [
                [0, 0],
                [0, :bomb]
            ]

            board = Board.new(2, 2)
            board.set_cell_as_bomb(1,1)
            expect(board.data_matrix).to eq(expected)
        end
    end
     
    context "#cell_a_bomb?" do
        it "should return true if the cell is a bomb" do
            board = Board.new(2, 2)
            i_index = 1
            j_index = 1
            board.set_cell_as_bomb(i_index, j_index)
            expect(board.cell_a_bomb?(i_index, j_index)).to be_truthy
        end
        
        it "should return false if the cell is not a bomb" do
            board = Board.new(2, 2)
            i_index = 1
            j_index = 1
            expect(board.cell_a_bomb?(i_index, j_index)).to be_falsey
        end
    end

    context "#bombs?" do
        it "should return true if the board has bombs" do
            board = Board.new(2, 2)
            board.set_cell_as_bomb(1, 1)
            expect(board.bombs?).to be_truthy
        end
        
        it "should return false if the board does not have bombs" do
            board = Board.new(2, 2)
            expect(board.bombs?).to be_falsey
        end
    end

    context "#bomb_count" do
        it "should return 0 when there is no bombs on the board" do
            board = Board.new(2, 2)
            expect(board.bomb_count).to be_zero
        end
        
        it "should return the bomb count if there are bombs set" do
            board = Board.new(2, 2)
            board.set_cell_as_bomb(1, 1)
            board.set_cell_as_bomb(0, 1)
            expect(board.bomb_count).to eq(2)
        end
    end

    context "#populate_adjacent_numbers" do
        it "should correctly populate all the bomb-adjacent-numbers" do
            expected = [
                [:bomb, 1, 0, 0, 0],
                [1, 1, 0, 1, 1],
                [0, 0, 0, 1, :bomb],
                [0, 1, 2, 4, 3],
                [0, 1, :bomb, :bomb, :bomb]
            ]

            board = Board.new(5, 5)
            board.set_cell_as_bomb(0,0)
            board.set_cell_as_bomb(2,4)
            board.set_cell_as_bomb(4,2)
            board.set_cell_as_bomb(4,3)
            board.set_cell_as_bomb(4,4)
            board.populate_adjacent_numbers
            expect(board.data_matrix).to eq(expected)
        end
    end
end
