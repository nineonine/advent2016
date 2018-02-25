module Day4 where

import System.IO (readFile)
import Data.Char (isDigit)
import Data.List (sortBy)
import Data.Tuple (swap)
import Data.Ord (Down(..), comparing)
import qualified Data.Map.Strict as M

getInput :: IO String
getInput = readFile "day4.txt"

type EncName  = String
type CheckSum = String
type SectorId = Int
data Room a   = Room SectorId CheckSum a deriving (Eq, Show)

instance Functor Room where
  fmap f (Room sid cs a) = Room sid cs (f a)

strToRoom :: String -> Room String
strToRoom s  = Room sid cs ename where
  (ename, s') = break isDigit s
  (sid,  s'') = swap . fmap read . swap $ span (/= '[') s'
  cs          = tail $ init s''

decryptName :: String -> CheckSum
decryptName = getCheckSum . toMap . filter (/= '-')

toMap :: String -> M.Map Char Int
toMap [] = M.empty
toMap s  = foldl go M.empty s where
   go acc k = if M.notMember k acc
                 then M.insert k 1 acc
                 else M.adjust (+1) k acc

getCheckSum :: (Ord b) => M.Map a b -> [a]
getCheckSum = map snd . take 5 . sortDesc . fmap swap . M.toList where
  sortDesc = sortBy ( comparing (Down . fst) )

isReal :: Room String -> Bool
isReal (Room _ cs s) = cs == s

getSectorId :: Room a -> SectorId
getSectorId (Room sid _ _) = sid

sumOfRealRooms :: [Room CheckSum] -> Int
sumOfRealRooms = foldl go 0 where
  go acc r = if isReal r
               then acc + getSectorId r
               else acc

runProgram :: IO Int
runProgram = (sumOfRealRooms . toRooms . lines) <$> getInput where
  toRooms = fmap (fmap decryptName . strToRoom)
