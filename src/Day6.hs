module Day6
    (
    ) where

import Prelude hiding (lookup)
import qualified Data.List as L
import Data.Map.Strict hiding (foldl')
import Control.Applicative ((<$>))


getInput :: IO [String]
getInput = lines <$> readFile "day6.txt"

type Frequency = Int
type MFChar = (Char, Frequency) -- Most frequently used character in a list
data MapWithMax = MWM (Maybe MFChar) (Map Char Frequency) deriving (Show, Eq)

unit' :: MapWithMax
unit' = MWM Nothing empty

insert' :: MapWithMax -> Char -> MapWithMax
insert' (MWM  Nothing       pairs) c = MWM (Just (c,1)) (insert c 1 pairs)
insert' (MWM (Just (mfc,i)) pairs) c
  | mfc == c             = MWM (Just (mfc, succ i)) (adjust succ mfc pairs)
  | not (member c pairs) = MWM (Just (mfc, i))       (insert c 1 pairs)
  | otherwise = let
                  pairs'    = adjust succ c pairs
                  Just cI   = lookup c pairs'
                in
                  if cI > i
                     then MWM (Just (c, cI)) pairs'
                     else MWM (Just (mfc,i)) pairs'

toMWM :: String -> MapWithMax
toMWM = L.foldl' insert' unit'

getChar' :: MapWithMax -> Char
getChar' (MWM (Just (mfc, _)) _ ) = mfc

-- PART ONE
solve :: [String] -> String
solve []  = []
solve ss  = (getChar' . toMWM) <$> L.transpose ss
