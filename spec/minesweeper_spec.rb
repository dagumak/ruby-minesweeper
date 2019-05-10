require "#{__dir__}/../src/minesweeper"

RSpec.describe Minesweeper do
  context '#status' do
    it 'should display a message for victory' do
      game = Minesweeper.new(1, :easy, :god)
      expect { game.attempt(1,1) }.to output(/Congratualations! You won!/).to_stdout
    end

    it "should display a message for losing" do
      game = Minesweeper.new(1)
      expect { game.attempt(1,1) }.to output(/Game over! Better luck next time!/).to_stdout
    end
    
    it "should dislay a message when the game is not over" do
      game = Minesweeper.new(5, :easy, :god)
      expect { game.attempt(1,1) }.to output(/Game isn't over yet, make your move!/).to_stdout
    end
  end
end
