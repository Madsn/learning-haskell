module Main where

type Board = String

getRow :: Board -> Int -> String
getRow b rowNum =
    let r = rowNum * 3 in
    "|  " ++
    b!!r     : "  |  " ++
    b!!(r+1) : "  |  " ++
    b!!(r+2) : "  |\n"

getBoard :: Board -> String
getBoard board =
    "+-----+-----+-----+\n" ++
    "|     |     |     |\n" ++
    getRow board 0 ++
    "|     |     |     |\n" ++
    "+-----+-----+-----+\n" ++
    "|     |     |     |\n" ++
    getRow board 1 ++
    "|     |     |     |\n" ++
    "+-----+-----+-----+\n" ++
    "|     |     |     |\n" ++
    getRow board 2 ++
    "|     |     |     |\n" ++
    "+-----+-----+-----+\n"

numberRange :: [Char]
numberRange = "123456789"

validMoves :: Board -> String
validMoves b = [ x | x <- numberRange, x `elem` b ]

main = do
    let board = numberRange
    putStrLn "Tic Tac Toe\n"
    putStrLn $ getBoard board
    putStrLn $ "Valid moves: " ++ validMoves board
