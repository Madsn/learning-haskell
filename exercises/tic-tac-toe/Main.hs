module Main where

import System.Exit (exitSuccess)
import Data.List (intersperse)
import Data.Sequence (fromList, update)
import Data.Foldable (toList)
import Control.Monad
import Control.Monad.Reader
import Data.Char (digitToInt)

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

firstAvailable :: Board -> Int
firstAvailable b = subtract 1 . digitToInt $ head $ filter (liftM2 (&&) (/='O') (/='X')) b

playerTurn :: Board -> IO ()
playerTurn b = do
    putStrLn $ "Choose one of the available fields: " ++ validMoves b
    move <- getLine
    let newBoard = updateBoard (subtract 1 $ read move :: Int) 'O' b
    putStrLn $ getBoard newBoard
    computerTurn newBoard

computerTurn :: Board -> IO ()
computerTurn b = do
    putStrLn "Computers turn"
    let move = firstAvailable b
    putStrLn $ "Computer chooses: " ++ show move
    let newBoard = updateBoard move 'X' b
    putStrLn $ getBoard newBoard

updateBoard :: Int -> Char -> Board -> Board
updateBoard i c b = toList $ update i c $ fromList b


main :: IO ()
main = do
    let board = numberRange
    putStrLn "Welcome to Tic Tac Toe\n"
    putStrLn $ getBoard board
    putStrLn "You are O"
    playerTurn board
