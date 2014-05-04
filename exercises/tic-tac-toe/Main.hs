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

main = do
    putStrLn "Tic Tac Toe\n"
    putStrLn $ getBoard "123456789"
