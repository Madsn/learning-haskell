{-|
(*) Find the number of elements of a list.

Example in Haskell:

Prelude> myLength [123, 456, 789]
3
Prelude> myLength "Hello, world!"
13
-}
myLength :: [a] -> Int
--myLength = length
myLength [] = 0
myLength (_:x) = 1 + myLength x