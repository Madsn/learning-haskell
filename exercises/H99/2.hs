{-|
(*) Find the last but one element of a list.

(Note that the Lisp transcription of this problem is incorrect.)

Example in Haskell:

Prelude> myButLast [1,2,3,4]
3
Prelude> myButLast ['a'..'z']
'y'
-}
myButLast :: [a] -> a
--myButLast x = x !! (length x-2)
myButLast x = (reverse x) !! 1
-- favorite solution from site
--myButLast = last . init
-- init: returns all elements of list except the last one
-- corresponds to: `last (init [1,2,3,4])`