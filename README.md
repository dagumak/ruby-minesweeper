# Minesweeper

## How to play?


## Adding Additional Difficulties
Currently there are only 3 difficulties: easy, medium, and hard

Perhaps you want to perform different algorithms to better spread out the bomb placement or you want to create weird and wacky bomb placements that just run around the border, you can extend this program using the strategy pattern and implement your own populating method.

If you wanted to add additional difficulties, you could create a new strategy and update the switch case statement to include your new strategy. Please refer to existing strategies such as `MediumBoardPopulatorStrategy`.

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