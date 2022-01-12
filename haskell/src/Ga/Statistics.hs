module Statistics where
-- Combinatorial functions
-- iteration
iter :: (a -> a) -> a -> [a]
iter f x = x : iter f (f x)
-- rotate
rotate:: Int -> [a] -> [a]
rotate n xs = zipWith const (drop n (cycle xs)) xs

rotations :: Int -> [a] -> [[a]]
rotations n xs = [rotate n xs]
-- rotations n xs = take n (iter rotate xs)



-- $ /sum_{r=n}^{n} {n}_C_{n-r} = nCn + n_C_{n-1} + ... +  n_C{n-r} +... + n_C_{n-n}$
-- simple substance 단체 ::subs [1,2]
--      subs 2 ++ map (1:) subs 2
--      ([[]] ++ map(2:) [[]]) ++ map (1:) ([[]] ++ map(2:) [[]])
-- subs [1,2,3]
--      (subs [2,3]) ++ map (1:) (subs [2,3])
--      (subs[3] ++ map(2:) subs [3]) ++ map (1:) (subs [3] ++ map (2:) subs [3])
subs :: [a] -> [[a]]
subs []     = [[]]
subs (x:xs) = (subs xs) ++ map (x:) (subs xs) -- = yss ++ map (x:) yss where yss = subs xs

