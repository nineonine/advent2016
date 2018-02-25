module Day19 where

newtype Elves a = Elves {
    unElves :: [a] -> [a]
  }

fromList ::  [a] -> Elves a
fromList xs = Elves (xs ++) 

toList :: Elves a -> [a]
toList  (Elves e) = e []

append :: Elves a -> Elves a -> Elves a
append (Elves e) (Elves e') = Elves (e . e')

instance Monoid (Elves a) where
  mappend = append
  mempty  = Elves id

solve :: [Int] -> Int
solve [] = 0
solve cs = f1 cs mempty

length' :: Elves a -> Int
length' = length . toList

f1 :: [a] -> Elves a  -> a
f1 []         c = if length' c == 1 then head $ toList c else f1 (toList c) mempty        
f1 [x]        c = f1 (x: toList c) mempty 
f1 (x:y:rest) c = f1 rest $ c `mappend` fromList [x]     

