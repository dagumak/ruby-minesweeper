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
end
