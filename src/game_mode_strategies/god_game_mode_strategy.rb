require "#{__dir__}/normal_game_mode_strategy"

# God Game Mode
# You are a god. Bombs don't touch you.
class GodGameModeStrategy < NormalGameModeStrategy
  def process_pair(index_pair)
    board.mark_as_seen!(*index_pair)

    return puts 'Silly Bombs 😂😂😂😂' if board.cell_a_bomb?(*index_pair)

    cell_value = board.cell_value(*index_pair)
    return unless cell_value.zero?

    board.adjacent_cells(*index_pair).each do |pair|
      stack.push(pair) if board.not_seen?(*pair)
    end
  end

  def won?
    board.unseen_cell_count.zero?
  end
end
