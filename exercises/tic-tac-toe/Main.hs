{-|
Second attempt
-}
module Main where

import System.Exit (exitSuccess)
import Data.Char (digitToInt)
import Safe
import Data.Set as Set
import Data.List (intersperse)

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

numberToSquare :: Char -> Maybe Square
numberToSquare '0' = Just SQ0
numberToSquare '1' = Just SQ1
numberToSquare '2' = Just SQ2
numberToSquare '3' = Just SQ3
numberToSquare '4' = Just SQ4
numberToSquare '5' = Just SQ5
numberToSquare '6' = Just SQ6
numberToSquare '7' = Just SQ7
numberToSquare '8' = Just SQ8
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

playerTurn :: GameState -> IO ()
playerTurn gs = do
    putStrLn $ "Choose a cell, enter one of the following: " ++ show (showValidMoves gs)


main :: IO ()
main = do
    let gs = (Set.empty, Set.empty)
    putStrLn "Welcome to Tic Tac Toe\n"
    putStrLn $ getBoard gs
    putStrLn "You are O"
    playerTurn gs
