module Lib (pset) where
import Data.ByteString (intercalate)

pset' :: [Int] -> [[Int]]
pset' [] = [[]]
pset' (x:xs) = pset' xs  ++ (pset' xs)
-- pset' [] = [[]] 

-- pset' 1:[] = pset'([]) ++ pset' ([]) 
-- pset' 1:[] = [[],[]]

-- pset' 2:1:[] = pset'(1:[]) ++ pset' (1:[]) 
-- pset' 2:1:[] = [[],[]] ++ [[],[]] = [[],[],[],[]] 

-- pset' 3:2:1:[] = pset'(2:1:[]) ++ pset' (2:1:[]) 
-- pset' 3:2:1:[] = [[],[],[],[]] ++ [[],[],[],[]] = [[],[],[],[],[[],[],[],[]] 

pset :: [a] -> [[a]]
pset [] = [[]]
pset (x:xs) = pset xs ++ map (x:) (pset xs)
-- [] = [[]]
-- (1:[]) = [[]] ++ map (1:) [[]] = [[],[1]]
-- (2:1:[]) = [[],[1]] ++ map (2:) [[],[1]] = [[],[1],[2],[2,1]]

interleave:: a -> [a] -> [[a]]
interleave x [] = [[x]]
interleave x (y:ys) = [(x:y:ys)] ++ map (y:) (interleave x ys)
-- interleave x (y:ys) = [x:y:ys] ++ map (y:) (interleave x ys)
-- interleave x (y:ys) = (x:y:ys) : map (y:) (interleave x ys)
-- x [] =  [[x]]
-- x 1:[] =  [[x:1],[1,x]]
-- x 2:1:[] =  [[x,2,1],[2,x,1],[2,1,x]]

perm :: [a] -> [[a]]
perm [] = [[]]
perm (x:xs) = concat $ map (interleave x) (perm xs)

-- [] = [[]]

-- 1:[] = [[1]]
-- 2:1:[] = [[2,1],[1,2]]
---- 1:[] = 2 :: [[1]]

-- 3:2:1:[] = [[3:2:1], [3:1,2],[2,3,1],[2,1,3],[1,3,2],[1,2,3]]]
---- 2:1:[] = 3::[[2,1],[1,2]]

-- 4:3:2:1:[] = [
--                [4:3:2:1]: [4:3:1:2]:[4:2:3:1]:[4:2:1:3]:
--                [3:4:2:1]:[3:4:1:2]:[3:2:4:1]:[3:2:1:4]:[3:1:4:2]:[3:1:2:4]:
--                [2:4:3:1]:[2:4:1:3][2:3:4:1]:[2:3:1:4]:
--                [1:4:3:2]:[1:4:2:3]:[1:3:4:2]:[1:3:2:4]:[1:2:4:3]:[1:2:3:4]]
---- 3:2:1:[] = 4 :: [[3:2:1]: [3:1:2]:[2:3:1]:[2:1:3]:[1:3:2]:[1:2:3]]]

ncr :: [a] -> Int -> [[a]]
ncr _ 0 = [[]]
ncr xs n = filter (\x -> length x == n) $ pset xs

npr :: [a] -> Int -> [[a]]
npr _ 0 = [[]]
npr (xs) n = concat $ map  perm $ filter (\x -> length  x == n) $ pset (xs)
