require "#{__dir__}/../src/board"
require "#{__dir__}/../src/board_populator"
Dir[File.join(__dir__, 'populator_strategies', '*.rb')].each { |file| require file }

RSpec.describe BoardPopulator do
    context "#populate_by_difficulty_level" do
        let(:board) { Board.new(5,5) }
        let(:board_populator) { BoardPopulator.new(board) }

        it "should return use the easy strategy to populate the board" do        
            strategy = board_populator.get_strategy_by_difficulty_level(:easy)
            expect(strategy).to be_an_instance_of(EasyBoardPopulatorStrategy)
        end

        it "should return use the medium strategy to populate the board" do
            strategy = board_populator.get_strategy_by_difficulty_level(:medium)
            expect(strategy).to be_an_instance_of(MediumBoardPopulatorStrategy)
        end

        it "should return use the hard strategy to populate the board" do
            strategy = board_populator.get_strategy_by_difficulty_level(:hard)
            expect(strategy).to be_an_instance_of(HardBoardPopulatorStrategy)
        end
       
    end
end
