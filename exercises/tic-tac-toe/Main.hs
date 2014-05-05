module Main where

import System.Exit (exitSuccess)
import Data.List (intersperse)
import Data.Sequence
import Data.Foldable (toList)

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
validMoves b = intersperse ',' [ x | x <- numberRange, x `elem` b ]

playerTurn :: Board -> IO ()
playerTurn b = do
    putStrLn $ "Choose one of the available fields: " ++ validMoves b++ "\n"
    move <- getLine
    putStrLn $ getBoard $ toList $ update (subtract 1 $ read move :: Int) 'O' $ fromList b

main :: IO ()
main = do
    let board = numberRange
    putStrLn "Welcome to Tic Tac Toe\n"
    putStrLn $ getBoard board
    putStrLn "You are O"
    playerTurn board
