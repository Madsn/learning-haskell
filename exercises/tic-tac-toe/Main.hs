{-|
Second attempt
-}
module Main where

import System.Exit (exitSuccess)
import Data.Char (digitToInt)
import Safe

import Data.Set as Set

data Square = SQ0 | SQ1 | SQ2 | SQ3 | SQ4 | SQ5 | SQ6 | SQ7 | SQ8 deriving (Eq,Ord,Read,Show)

type GameState = (Set Square, Set Square)

squareToNumber :: Square -> String
squareToNumber s = [last $ show s]

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


main :: IO ()
main = do
    let gs = (Set.empty, Set.empty)
    putStrLn "Welcome to Tic Tac Toe\n"
    putStrLn $ getBoard gs
    putStrLn "You are O"
