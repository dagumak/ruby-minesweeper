# Minesweeper

## How to play?
```bash
$ irb
```

```ruby
irb(main) > load './src/minesweeper.rb'
irb(main) > game = Minesweeper.new(25)
```





## Adding Additional Difficulties
Currently there are only 3 difficulties: easy, medium, and hard

Perhaps you want to perform different algorithms to better spread out the bomb placement or you want to create weird and wacky bomb placements that just run around the border, you can extend this program using the strategy pattern and implement your own populating method.

If you wanted to add additional difficulties, you could create a new strategy and update the switch case statement to include your new strategy. Please refer to existing strategies such as `BaseBoardPopulatorStrategy` and `MediumBoardPopulatorStrategy`.

All Populator Strategies have to implement a method `populate` and it must return the `board`.

## Adding Additional Game Modes

Let's say we want to just disable bomb detonation, we can add a strategy pattern called `GodGameModeStrategy` that will essentially always allow us to win because we can't lose.

## Running tests
```bash
$ rspec
```

## Running the linter
```bash
$ rubocop src/ --auto-correct
```

# Terminology
In the Board class, you will notice that I use the terminology `indices` instead of `coordinates`. `Indices` are array indices, so they start from 0. On the other hand, coordinates start at 1 and the terminology `coordinates` is only used in the Minesweeper class which is the actual game.