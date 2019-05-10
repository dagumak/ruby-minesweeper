# Minesweeper

![dagumak's Minesweeper](images/dagumak-minesweeper.png)


## How to play?
```bash
$ irb
```

```ruby
irb(main) > load './src/minesweeper.rb'
irb(main) > game = Minesweeper.new(25)
```
### Viewing the board
```ruby
irb(main) > game.display
```

### Selecting a Cell
```ruby
irb(main) > game.attempt(1, 1)
```

## Fun Features

#### Dagumak Level Difficulty

```ruby
irb(main) > load './src/minesweeper.rb'
irb(main) > game = Minesweeper.new(25, :dagumak)
irb(main) > game.display_with_map_hack
```

#### Map Hack
This will unveil the fog of war and reveal all the whole board.

```ruby
irb(main) > load './src/minesweeper.rb'
irb(main) > game = Minesweeper.new(25)
irb(main) > game.display_with_map_hack
```

#### God Mode
This will grant the player god mode. In god mode, you can select a cell that is a bomb without penalty; you will *eventually* always win.

```ruby
irb(main) > load './src/minesweeper.rb'
irb(main) > game = Minesweeper.new(25, :hard, :god)
```

# Developer Notes
## Architecture Overview

`class Minesweeper`

> This class is for player interaction; the class displays the board to the player, understands the current game state (ex, in progress, loss, or win), and allows players to make a move. It's main function is to orchestrate other classes to make a functional game.

`class Board`

> This class is for managing the Minesweeper matrix itself. It understands how to populate all the `bomb-adjacent-numbers`, but does not know where to places the bombs; it knows how to surround bombs with numbers, but does not know where to places the actual bombs itself. It relies on `BoardPopulatorFactory` for bomb placement.

`class BoardPopulatorFactory`

> This class is factory collection of strategies available for bomb placement. Currently, we have 3 difficulties which is easy, medium, and hard. There is a strategy class for each of the difficulties and each strategy understands how many bombs it has to place and sets it on the board.

`class GameModeFactory`

> This class is factory collection of game modes. A game mode determines how the Minesweeper game should react when you select a cell to reveal. For example, in `SimpleGameModeStrategy`, when you select a cell that is empty then it just reveals that cell. However, in `NormalGameModeStrategy` when you select an empty cell, then it proceeds to reveal all empty cells connected until it reaches a number. Lastly, in `GodGameModeStrategy` when you select a cell and it's a bomb, nothing happens because you're in god mode.


## Code Terminology
`indices` - This is the index used to access a matrix in `class Board`. These numbers start at 0. Indices use `i_index, j_index` variables to prevent confusion with `coordinates`. 

`coordinates` - This is a pair of number for the player to select a cell on the board. Coordinates use `x, y` variables and start from 1 because normal players will start counting a column or row from 1. 

`bomb-adjacent-numbers` - The numbers surrounding a given bomb are the adjacent numbers. Each number represents the number of bombs that is surrounding it.

## Adding Additional Difficulties (Bomb Populating Strategies)
Currently there are only 3 difficulties: `easy`, `medium`, and `hard`

Perhaps you want to perform different algorithms to better spread out the bomb placement or you want to create weird and wacky bomb placements that just run around the border, you can extend this program using the strategy pattern and implement your own populating method.

If you wanted to add additional difficulties, you could create a new strategy and update the switch case statement to include your new strategy. Please refer to existing strategies such as `DagumakBoardPopulatorStrategy`, `BaseBoardPopulatorStrategy` and `MediumBoardPopulatorStrategy`.

All Populator Strategies have to implement a method `populate` and it must return the `board`.

## Adding Additional Game Modes

Let's say we want to just disable bomb detonation, we can add a strategy pattern called `GodGameModeStrategy` that will essentially always allow us to win because we can't lose. Actually, this already exists. Please refer to `Fun Features` section

## Running tests
```bash
$ rspec
```

## Running the linter
```bash
$ rubocop src/ --auto-correct
```

## TODO - Features yet to be implemented
* Flags - diffusing bomb