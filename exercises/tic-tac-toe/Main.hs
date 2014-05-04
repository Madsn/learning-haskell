module Main where

type Board = [Char]

getBoard :: Board
getBoard =
    "+---+---+---+\n" ++
    "| 1 | 2 | 3 |\n" ++
    "+---+---+---+\n" ++
    "| 4 | 5 | 6 |\n" ++
    "+---+---+---+\n" ++
    "| 7 | 8 | 9 |\n" ++
    "+---+---+---+\n"

main = do
    putStrLn "Tic Tac Toe\n"
    putStrLn getBoard