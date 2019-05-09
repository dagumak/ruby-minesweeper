Dir[File.join(__dir__, 'game_mode_strategies', '*.rb')].each { |file| require file }

class GameModeFactory
  attr_accessor :board
  attr_accessor :game_mode

  DEFAULT_MODE = :normal

  def initialize(board, game_mode = DEFAULT_MODE)
    @board = board
    @game_mode = game_mode
  end

  def get_strategy
    case game_mode
    when :normal
      @game_mode_strategy = NormalGameModeStrategy.new(board)
    when :god
      @game_mode_strategy = GodGameModeStrategy.new(board)
    else
      raise UnknownGameMode
    end
  end
end

class UnknownGameMode < StandardError; end
