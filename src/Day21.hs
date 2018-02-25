module Day21
    (
    ) where

type Position   = Int
type NumOfSteps = Int
data Direction = Left | Right deriving (Show, Eq)
data Operation = SwapPositions Position Position
               | Swapletters Char Char
               | Rotate Direction NumOfSteps
               | Reverse Position Position
               | Move Position Position
               deriving (Show, Eq)

