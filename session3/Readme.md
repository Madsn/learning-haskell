A more functional-looking implementation of clamp is this:
λ> let clamp minBound maxBound x = (!! 1) . sort $ [minBound,maxBound,x]
λ> clamp 10 20 5
10
λ> clamp 10 20 15
15
λ> clamp 10 20 22
20
λ>

As an exercise, prove using QuickCheck that the two implementations
are equivalent (modulo design choices like using tuples for
arguments).

As a second exercise, given a sha512sum as an input, break it up at
the letter-digit boundaries, using logic that looks as functionally
idiomatic as you can make it look.

As a third exercise, solve this constraint logic problem using Haskell:
Three little pigs, who each live in a different type of house, handed
out treats for Halloween.
No two pigs live in the same type of house.
No two pigs handed out the same type of treat.
Using the clues below, write a program that determines which pig lives
in which type of house, and what type of treat each pig handed out.
```
Petey Pig did not hand out the popcorn.
Pippin Pig does not live in the wood house.
The pig that lives in the straw house handed out popcorn.
Petunia Pig handed out apples.
The pig who handed out chocolate does not live in the brick house.
```
