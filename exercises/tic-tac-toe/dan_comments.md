not relying heavily enough on type system

modeling game state as string, not idiomatic

`data Square = SQ0 | SQ1 | ..`

pair of lists for player owned squares `([*player1 squares*], [*player2 squares*])`
```haskell
let gs = ([SQ1],[])
gs :: ([Square], [Square])
```

set ensures no duplicates, so we will make the pair contain two sets instead of two lists

import Data.Set as Set

- `Set.\\` difference between sets
- `Set.member`
- `Set.empty`
- `Set.insert`

list of winning combinations will be a list of sets, `Set.isSubsetOf` can be used with that list against the lists of cells owned by each player.

```haskell
data Square = SQ0 | SQ1 ... deriving (Read,Show,Eq,Ord)

read "SQ2" :: Square


-- read either 'Just Square' or 'Nothing'
import Safe
readMay "2" :: Maybe Square


-- define a set to hold all squares
let board = Set.fromList [SQ0, SQ1, SQ2, ..]
let gs = (Set.fromList [SQ2], Set.fromList [SQ3])
-- Finding available squares
board Set.\\ fst gs Set.\\ snd gs
-- Use Set.member to determine if input is one of the available squares
```