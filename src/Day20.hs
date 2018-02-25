module Day20
    (
    ) where

import Data.List (foldl', (\\), span)

type IP = Int

getInput :: IO String
getInput = readFile "day20.txt"

data Range = Range IP IP deriving Show

data ProgramState = PS Min Max [Range] deriving Show


