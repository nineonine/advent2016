module Day3 where

import Utilities

day3input :: IO String
day3input = getInput "input/day3.txt"

tokenize :: String -> [[Int]]
tokenize = fmap (fmap read . words) . lines

isValidTriangle :: [Int] -> Bool
isValidTriangle [a,b,c] = a+b > c && a+c > b && b+c > a
isValidTriangle _ = False

day3parOne :: IO ()
day3parOne = do
    inputs <- fmap tokenize day3input
    print . length $ filter isValidTriangle inputs

