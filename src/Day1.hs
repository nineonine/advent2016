{-# LANGUAGE BangPatterns #-}

module Day1 where

import Utilities

import Data.Foldable (foldl')
import Data.List.Split

type Distance = Int
data Step = Step Turn Distance deriving (Show)
data Turn = LeftTurn | RightTurn deriving (Show)
data Direction = N | E | W | S deriving (Show)
data State = State {
      direction :: !Direction
    , xCoords   :: !Distance
    , yCoords   :: !Distance
    } deriving (Show)

initialState :: State
initialState = State N 0 0

day1Input :: IO String
day1Input = getInput "input/day1.txt"

extractTokens :: String -> [String]
extractTokens = splitOn ", "

toStep :: String -> Step
toStep ('L':rest) = Step LeftTurn (read rest :: Int)
toStep ('R':rest) = Step RightTurn (read rest :: Int)

moveNorth d st = let newD = N; !newY = yCoords st + d; newX = xCoords st in State newD newX newY
moveWest  d st = let newD = W; !newX = xCoords st - d; newY = yCoords st in State newD newX newY
moveSouth d st = let newD = S; !newY = yCoords st - d; newX = xCoords st in State newD newX newY
moveEast  d st = let newD = E; !newX = xCoords st + d; newY = xCoords st in State newD newX newY

updateState :: State -> Step -> State
updateState st (Step LeftTurn d) = case direction st of
    N -> moveWest d st
    E -> moveNorth d st
    W -> moveSouth d st
    S -> moveEast d st
updateState st (Step RightTurn d) = case direction st of
    N -> moveEast d st
    E -> moveSouth d st
    W -> moveNorth d st
    S -> moveWest d st

resultPartOne :: [Step] -> State -> Distance
resultPartOne []    _  = 0
resultPartOne steps st = result
    where
        State _ x y = foldl' updateState st steps
        result = abs $ x + y

