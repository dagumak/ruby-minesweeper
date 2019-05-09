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
        it "should return true when given indices outside of the matrix" do
            x_dimension = 1
            y_dimension = 2
            board = Board.new(x_dimension, y_dimension)
            expect(board.out_of_bounds?(x_dimension+1, y_dimension)).to be_truthy
        end
        it "should return true when given negative indices outside of the matrix" do
            x_dimension = 1
            y_dimension = 2
            board = Board.new(x_dimension, y_dimension)
            expect(board.out_of_bounds?(-1, -1)).to be_truthy
        end
       
        it "should return false when given indices inside of the matrix" do
            x_dimension = 1
            y_dimension = 2
            board = Board.new(x_dimension, y_dimension)
            expect(board.out_of_bounds?(x_dimension-1, y_dimension-1)).to be_falsey
        end
    end
    
    context "#cell_count?" do
        it "should return true when given indices out side of the matrix" do
            x_dimension = 1
            y_dimension = 2
            board = Board.new(x_dimension, y_dimension)
            expect(board.cell_count).to eq(x_dimension*y_dimension)
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
end
