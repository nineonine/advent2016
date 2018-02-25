module Day2 where

import Utilities

import Data.Char (isDigit, digitToInt, intToDigit)
import Data.Foldable (foldl')

type Result = String
type Direction = Char
type Button = Char
type FoldingFunction = (Button -> Direction -> Button)

day2Input :: IO String
day2Input = getInput "input/day2.txt"

run :: FoldingFunction -> Button -> [String] -> Result
run f _ []     = []
run f p (x:xs) = let p' = foldl' f p x
                      in p' : run f p' xs

partOne :: Button -> [String] -> Result
partOne = run move

partTwo :: Button -> [String] -> Result
partTwo = run move'

times :: Enum a => Int -> (a -> a) -> a -> a
times n f = foldr (.) id (replicate n f)

move :: FoldingFunction
move btn 'U' = if btn `elem` ['1','2','3'] then btn else times 3 pred btn
move btn 'D' = if btn `elem` ['7','8','9'] then btn else times 3 succ btn
move btn 'L' = if btn `elem` ['1','4','7'] then btn else pred btn
move btn 'R' = if btn `elem` ['3','6','9'] then btn else succ btn

move' :: FoldingFunction
move' btn 'U' = if btn `elem` ['5','2','1','4','9'] then btn else moveUp btn
move' btn 'D' = if btn `elem` ['5','A','D','C','9'] then btn else moveDown btn
move' btn 'L' = if btn `elem` ['1','2','5','A','D'] then btn else pred btn
move' btn 'R' = if btn `elem` ['1','4','9','C','D'] then btn else succ btn

moveUp :: Char -> Char
moveUp '3' = '1'
moveUp 'D' = 'B'
moveUp c
    | isDigit c = times 4 pred c
    | otherwise = intToDigit . times 4 pred $ digitToInt c

moveDown :: Char -> Char
moveDown 'B' = 'D'
moveDown '1' = '3'
moveDown c
    | (>) 5 $ digitToInt c = times 4 succ c
    | otherwise = case c of '6' -> 'A'; '7' -> 'B'; _ -> 'C'


