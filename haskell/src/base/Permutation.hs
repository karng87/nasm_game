module Permutation where
import Data.List
import Control.Monad
import Distribution.Simple.Utils (xargs)

-- append ++
-- cons :

-- power set = 2^{n} => to be or not to be per element
pset:: [a] -> [[a]]
pset [] = [[]]
pset (x:xs) =  pset xs ++ map (x:) (pset xs)

-- Conbination nCr
combi :: [a] -> Int -> [[a]]
combi xs n = filter (\x -> length x == n) (pset xs)

-- Permutation nPr
permations  xs = do
  x <- xs
  y <- delete x xs -- delete \iff import Data.List
  z <- delete y (delete x xs)
  return [x, y, z]

permu :: Eq a => [a] -> Int -> [[a]]
permu xs 0 = [[]]
permu xs n = xs >>= (\x -> (x:) <$> permu (delete x xs) (n-1) )

p xs = permu xs <$> [1..length xs]
pj xs = join $ p xs --  join \iff import Control.Monad
