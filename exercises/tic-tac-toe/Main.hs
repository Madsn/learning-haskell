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

squareFromString :: String -> Maybe Square
squareFromString "0" = Just SQ0
squareFromString "1" = Just SQ1
squareFromString "2" = Just SQ2
squareFromString "3" = Just SQ3
squareFromString "4" = Just SQ4
squareFromString "5" = Just SQ5
squareFromString "6" = Just SQ6
squareFromString "7" = Just SQ7
squareFromString "8" = Just SQ8
squareFromString _ = Nothing

checkIfValidMove :: GameState -> Square -> Maybe Square
checkIfValidMove gs s
    | Set.member s $ validMoves gs = Just s
    | otherwise = Nothing

readPlayerMove :: GameState -> String -> Maybe Square
readPlayerMove gs inp = squareFromString inp >>= checkIfValidMove gs

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
    putStrLn $ "Square: " ++ show s
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
    let move = readPlayerMove gs input -- Maybe Square
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
