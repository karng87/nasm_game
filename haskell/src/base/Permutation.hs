module Permutation where
import Data.List
import Control.Monad
import Distribution.Simple.Utils (xargs)

-- append ++
-- cons :

subs :: [a] -> [[a]]
subs  [] = [[]]
subs (x:xs) =  (subs xs)++ map (x:) (subs xs)

-- Conbination nCr
combi :: [a] -> Int -> [[a]]
combi xs n = filter (\x -> length x == n) (subs xs)

-- Permutation nPr
permations  xs = do
  x <- xs
  y <- delete x xs 
  z <- delete y (delete x xs)
  return [x, y, z]

permu :: Eq a => [a] -> Int -> [[a]]
permu xs 0 = [[]]
permu xs n = xs >>= (\x -> (x:) <$> (permu (delete x xs) (n-1)) )
