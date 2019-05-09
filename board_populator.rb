Dir[File.join(__dir__, 'populator_strategies', '*.rb')].each { |file| require file }

class BoardPopulator
    attr_accessor :board
    DEFAULT_DIFFICULTY_LEVEL = :easy
    DIFFICULTY_LEVELS = [
        DEFAULT_DIFFICULTY_LEVEL,
        :medium,
        :hard
    ]

    def initialize(board)
        @board = board        
    end

    def populate_by_difficulty_level(difficulty_level = DEFAULT_DIFFICULTY_LEVEL)
        case difficulty_level
        when :easy
            strategy = EasyBoardPopulatorStrategy.new(board)
        when :medium
            strategy = MediumBoardPopulatorStrategy.new(board)
        when :hard
            strategy = HardBoardPopulatorStrategy.new(board)
        else
            raise UnknownDifficultyLevel
        end
        strategy.populate
    end
end

class UnknownDifficultyLevel < StandardError; end