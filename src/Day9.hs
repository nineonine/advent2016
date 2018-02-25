{-# LANGUAGE DeriveFunctor #-}

module Day9 where

{-|
   Proof of concept for recursion schemes.
   https://pdfs.semanticscholar.org/fec6/b29569eac1a340990bb07e90355efd2434ec.pdf
   The program solves day 9 / part 1 from Advent Of Code 2016.
   http://adventofcode.com/2016/day/9
   The purpose of this solution is purely educational and self-gratifying.
   'recursion-schemes' library is used.
   In order for the program to work - input string should be put in 'input.txt'
-}

import System.IO (readFile)
import Data.Tuple (swap)
import Data.Functor.Foldable

getInput :: IO String
getInput = readFile "input.txt"

type Times  = Int
type Length = Int
type Seq    = Fix SeqF
data SeqF a = CompressedF Times String a
            | UncompressedF String a
            | EndOfSeqF
            deriving (Show, Functor)

extract :: String -> Maybe (Length, Times, String)
extract ('(':xs)  = Just (l, t, s') where
        (s , l)   = fmap read . swap $ span (/= 'x') xs
        (s', t)   = fmap read . swap . fmap tail . span (/= ')') $ tail s
extract _         = Nothing

getLength :: String -> Int
getLength = hylo alg coalg where
    alg   = length'
    coalg = toSeq

toSeq :: String -> SeqF String
toSeq [] = EndOfSeqF
toSeq s  = case extract s of
                Nothing           -> UncompressedF raw s'
                                     where (raw, s') = span (/= '(') s
                Just (l, t, rest) -> CompressedF t section rest'
                                     where (section, rest')  = splitAt l rest

length' :: SeqF Int -> Int
length' EndOfSeqF           = 0
length' (CompressedF t s r) = t * length s + r
length' (UncompressedF s r) = length s + r

runProgram :: IO Int
runProgram = getLength <$> getInput
