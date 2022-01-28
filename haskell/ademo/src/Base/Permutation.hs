module Base.Permutation where

import Data.List
import Control.Monad
import Distribution.Simple.Utils (xargs)

-- (++) <=> Union <=> append
-- (:) <=> construct one Element <=> cons

-- split
split :: [a] -> [([a],[a])]
split [] = []
split [_] = []
--split (x:xs) = ([x],xs) : (split xs >>= \(lhs,rhs) -> [(x:lhs,rhs)])
split (x:xs) = ([x],xs) : (map (\(lhs,rhs) -> (x:lhs,rhs)) (split xs))

-- [1,2,3,4]
-- split [] =  []
-- 
-- split [4] = []
-- 
-- split [3,4] = ([3],4:[]) : [(3:[lhs],[rhs]) | (lhs, rhs) <- slit [4] ]
-- split [3,4] = ([3],[4]) : [(3:[lhs],[rhs]) | (lhs, rhs) <- [] ]
-- 
-- split [3,4] = ([3],[4]) : [] =====> [([3],[4])]
-- 
-- split [2,3,4] = ([2],[3,4]) : [(2:[lhs],[rhs]) | (lhs, rhs) <- split [3,4] ]
-- split [2,3,4] = ([2],[3,4]) : [([2,3],[4])]
-- split [2,3,4] = [([2],[3,4]) , ([2,3],[4])]
-- 
-- split [1,2,3,4] = ([1],[2,3,4]) : [(1:[lhs],[rhs]) | (lhs, rhs) <- split [2,3,4] ]
-- split [1,2,3,4] = ([1],[2,3,4]) : [([1,2],[3,4]) , ([1,2,3],[4])]


-- split [] = []
-- split [_] = []
-- split (x:xs) = ([x],xs) : [(x:lhs, rhs) | (lhs, rhs) <- split xs]


-- interleave 끼워넣기
--    [1,2] <=> 1:2:[] <=> right asociate
--    []:[[]] => [[],[]]
--    1:[]:[[]] => error  but
--    (1:[]):[[]] => [[1],[]]OK 

-- x 가 한칸씩 뒤로 들어간다.
interleave :: a -> [a] -> [[a]]
interleave x [] = [[x]]
interleave x (y:ys) = (x:y:ys) : map (y:) (interleave x ys)
-- interleave x (y:ys) = (x:y:ys) : ((y:) <$> interleave x ys)
-- interleave x (y:ys) = [x:y:ys] ++ map (y:) (interleave x ys)

ilpermuA :: [a] -> [[a]]
ilpermuA [] = [[]]
ilpermuA (x:xs) = ilpermuA xs >>= interleave x

-- TODO exception
ilpermu :: [a] -> Int -> [[a]]
ilpermu [] 0 = [[]]
ilpermu (x:xs) n = ilpermu xs (n-1)>>= interleave x

-- power set = 2^{n} => to be or not to be per element
--    needed empty set
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

