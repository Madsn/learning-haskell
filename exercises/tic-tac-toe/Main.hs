module Main where

import System.Exit (exitSuccess)
import Data.List (intersperse, isInfixOf)
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

printBoard :: Board -> IO ()
printBoard b = putStrLn $ getBoard b

numberRange :: String
numberRange = "123456789"

validMoves :: Board -> String
validMoves b = [ x | x <- numberRange, x `elem` b ]

winningCombinations :: [[Int]]
winningCombinations = [[0,1,2],[3,4,5],[6,7,8],[0,4,8],[1,4,7],[2,4,6],[0,3,6],[2,5,8]]

foo b c t = c == b !! t

allEquals :: Board -> Char -> [Int] -> Bool
allEquals b c t = and $ map (foo b c) t

hasWon :: Char -> Board -> Bool
hasWon c b = or $ map (allEquals b c) winningCombinations


gameOverCheck :: Board -> [Char]
gameOverCheck b =
    if hasWon 'O' b then
        "O"
    else
        if hasWon 'X' b then
            "X"
        else
            []

printGameOver :: String -> IO ()
printGameOver p = putStrLn $ p ++ " Wins!\n ---- Game over ----"

gameTied :: Board -> Bool
gameTied b = not $ any (liftM2 (&&) (/='X') (/='O')) b

isValidMove :: String -> Board -> Bool
isValidMove m b = m `isInfixOf` validMoves b

getPlayerMove :: Board -> Int
getPlayerMove b = do
    putStrLn $ "Choose one of the available fields: " ++ intersperse ',' $ validMoves b
    move <- getLine
    if isValidMove move b then
        subtract 1 $ read move
    else
        getPlayerMove b

playerTurn :: Board -> IO ()
playerTurn b = do
    if gameTied b then do
        printBoard b
        putStrLn "Tied game!"
        newGame
    else do
        let winningPlayer = gameOverCheck b
        if null winningPlayer then do
            let move = getPlayerMove b
            let newBoard = updateBoard move 'O' b
            computerTurn newBoard
        else do
            printGameOver winningPlayer
            newGame


firstAvailable :: Board -> Int
firstAvailable b = subtract 1 . digitToInt $ head $ filter (liftM2 (&&) (/='O') (/='X')) b

optimalChoice :: Board -> Int
optimalChoice b = 1

computerTurn :: Board -> IO ()
computerTurn b = do
    if gameTied b then do
        printBoard b
        putStrLn "Tied game!"
        newGame
    else do
        let winningPlayer = gameOverCheck b
        if null winningPlayer then do
            putStrLn "Computers turn"
            let move = firstAvailable b
            putStrLn $ "Computer chooses: " ++ show move
            let newBoard = updateBoard move 'X' b
            printBoard newBoard
            playerTurn newBoard
        else do
            printGameOver winningPlayer
            newGame

updateBoard :: Int -> Char -> Board -> Board
updateBoard i c b = toList $ update i c $ fromList b

main :: IO ()
main = do
    let board = numberRange
    putStrLn "Welcome to Tic Tac Toe\n"
    printBoard board
    putStrLn "You are O"
    playerTurn board

newGame :: IO ()
newGame = do
    putStrLn "Play again? y/n"
    choice <- getLine
    if choice == "y" then
        main
    else if choice == "n" then do
        putStrLn "Goodbye!"
        exitSuccess
    else do
        putStrLn "Choice not recognized."
        newGame

