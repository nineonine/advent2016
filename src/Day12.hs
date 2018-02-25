{-# LANGUAGE DeriveFunctor #-}

module Day12 where

import Data.Char (isAlpha)
import System.IO (readFile)
import Data.Functor.Foldable

getInput :: IO String
getInput = readFile "day12.txt"

data Registers = Registers { a :: Int, b :: Int, c :: Int, d :: Int } deriving (Eq, Show)
data Source = RegS ( Registers -> Int ) | Lit Int
instance Show Source where
    show (RegS _) = "RegSource"
    show (Lit i)  = "Lit " ++ show i

type Tag = String
type Zipper = ([Raw], [Raw])

back :: Int -> Zipper -> Zipper
back 0 z          = z
back _ z@(_,[])   = z
back n (xs, y:ys) = back (n-1) (y:xs, ys)

next :: Int -> Zipper -> Zipper
next 0 z          = z
next _ z@([],_)   = z
next n (x:xs, ys) = next (n-1) (xs, x:ys)

data Raw = Cpy Source Tag
         | Inc Tag
         | Dec Tag
         | Jnz Tag Int
         deriving Show

type ISet     = Fix InstrF
data InstrF a = CpyF String Char a
              | IncF Char a
              | DecF Char a
              | End
              deriving (Show, Functor)

-- h - history/breadcrumbs
-- t - register tag
--execute :: Zipper -> Registers -> Registers
--execute ([], _) r = r
--execute ((Inc t):rest, h) r = execute rest r' where r' = r { getterFor t r = getterFor t r

--updateRegWith :: (Num a) => (a -> a) -> Registers -> Tag -> Registers
--updateRegWith _ r  =
--updateRegWith f r t =

getterFor :: String -> Registers -> Int
getterFor s = case s of "a" -> a;"b" -> b;"c" -> c;"d" -> d; _ -> const 0

parse :: [String] -> [Raw]
parse = fmap parseI

parseI :: String -> Raw
parseI s = case head $ words s of
             "inc" -> Inc r where [_,r] = words s
             "dec" -> Dec r where [_,r] = words s
             "jnz" -> Jnz r i' where [_,r,i] = words s; i' = read i
             "cpy" -> Cpy src dest
               where [_,from, dest] = words s
                     src = if isAlpha $ head from
                              then RegS ( getterFor $from )
                              else Lit ( read from )



