{-|
Second attempt
-}
module Main where

import System.Exit (exitSuccess)
import Data.Char (digitToInt)
import Safe
import Data.Set as Set
import Data.List (intersperse)
import Data.Maybe (fromJust)

data Square = SQ0 | SQ1 | SQ2 | SQ3 | SQ4 | SQ5 | SQ6 | SQ7 | SQ8 deriving (Eq,Ord,Read,Show)

type GameState = (Set Square, Set Square)

board :: Set Square
board = Set.fromList [SQ0, SQ1, SQ2, SQ3, SQ4, SQ5, SQ6, SQ7, SQ8]

validMoves :: GameState -> Set Square
validMoves gs = board Set.\\ fst gs Set.\\ snd gs

showValidMoves :: GameState -> String
showValidMoves gs = unwords $ Set.toList $ Set.map squareToNumber $ validMoves gs

squareToNumber :: Square -> String
squareToNumber s = [last $ show s]

numberToSquare :: String -> Maybe Square
numberToSquare "0" = Just SQ0
numberToSquare "1" = Just SQ1
numberToSquare "2" = Just SQ2
numberToSquare "3" = Just SQ3
numberToSquare "4" = Just SQ4
numberToSquare "5" = Just SQ5
numberToSquare "6" = Just SQ6
numberToSquare "7" = Just SQ7
numberToSquare "8" = Just SQ8
numberToSquare _ = Nothing

getCell :: Square -> GameState -> String
getCell s gs
    | Set.member s $ fst gs = "O"
    | Set.member s $ snd gs = "X"
    | otherwise = squareToNumber s


getBoard :: GameState -> String
getBoard gs =
    "+-----+-----+-----+\n" ++
    "|     |     |     |\n" ++
    "|  " ++ (getCell SQ0 gs) ++ "  |  " ++ (getCell SQ1 gs) ++ "  |  " ++ (getCell SQ2 gs) ++ "  |\n" ++
    "|     |     |     |\n" ++
    "+-----+-----+-----+\n" ++
    "|     |     |     |\n" ++
    "|  " ++ (getCell SQ3 gs) ++ "  |  " ++ (getCell SQ4 gs) ++ "  |  " ++ (getCell SQ5 gs) ++ "  |\n" ++
    "|     |     |     |\n" ++
    "+-----+-----+-----+\n" ++
    "|     |     |     |\n" ++
    "|  " ++ (getCell SQ6 gs) ++ "  |  " ++ (getCell SQ7 gs) ++ "  |  " ++ (getCell SQ8 gs) ++ "  |\n" ++
    "|     |     |     |\n" ++
    "+-----+-----+-----+\n"

updateGameState :: GameState -> Square -> Char -> GameState
updateGameState gs s 'O' = (Set.insert s $ fst gs, snd gs)
updateGameState gs s _ = (fst gs, Set.insert s $ snd gs)

handlePlayerMove :: GameState -> Maybe Square -> IO ()
handlePlayerMove gs (Just s) = do
    let newGs = updateGameState gs s 'O'
    computerTurn newGs
handlePlayerMove gs Nothing = do
    putStrLn "Invalid input, try again."
    playerTurn gs

playerTurn :: GameState -> IO ()
playerTurn gs = do
    putStrLn $ getBoard gs
    putStrLn $ "Choose a cell, enter one of the following: " ++ show (showValidMoves gs)
    input <- getLine
    let move = numberToSquare input -- Maybe Square
    handlePlayerMove gs move

firstAvailable :: GameState -> Square
firstAvailable gs = Set.findMin $ validMoves gs

computerTurn :: GameState -> IO ()
computerTurn gs = do
    playerTurn $ updateGameState gs (firstAvailable gs) 'X'

main :: IO ()
main = do
    putStrLn "Welcome to Tic Tac Toe"
    putStrLn "You are O"
    startGame

startGame :: IO ()
startGame = do
    let gs = (Set.empty, Set.empty)
    putStrLn "Do you wish to start? (y/n)"
    playerStarts <- getLine
    if playerStarts == "y" then
        playerTurn gs
    else if playerStarts == "n" then
        computerTurn gs
    else do
        putStrLn "Invalid input"
        startGame
