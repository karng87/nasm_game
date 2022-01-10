-- length
length' :: [a] -> Int
length' [] = 0
length' (_:xs) = 1 + length' xs

-- ++
append' :: [a] -> [a] -> [a]
append' [] ys = ys
append' xs [] = xs
append' (x:xs) ys = x : append' xs ys

-- reverse
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs `append'` [x]

-- zip
zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y) : zip' xs ys

-- drop
drop' :: Int -> [a] -> [a]
drop' 0 xs = xs
drop' _ [] = []
drop' n (x:xs) = drop' (n-1) xs

-- take
take' :: Int -> [a] -> [a]
take' 0 _ = []
take' n (x:xs) = x: take' (n-1) xs

-- insert 
insert' :: Int -> [Int] -> [Int]
insert' n [] = [n]
insert' n (x:xs) = if n <= x then n:(x:xs) else x : insert' n xs 

-- insertion sort
isort' :: [Int] -> [Int]
isort' [] = []
isort' (x:xs) = insert' x $ isort' xs

-- quick sort
qsort' :: Ord a => [a] -> [a]
qsort' [] = []
qsort' (x:xs) = qsort' lhs ++ [x] ++ qsort' rhs where 
                      lhs = [ x' | x' <- xs, x' < x]
                      rhs = [ x' | x' <- xs, x' >= x]

-- merge [] [] append with sorting
merge' :: Ord a => [a] -> [a] -> [a]
merge' [] y = y
merge' x [] = x
merge' (x:xs) (y:ys) = if x <= y then x : merge' xs (y:ys) else y : merge' (x:xs) ys

-- merge sort
msort' :: Ord a => [a] -> [a]
msort' [] = []
msort' [x] = [x]
msort' xs = merge' (msort' ys) (msort' zs) where
                  hl = div (length' xs) 2
                  ys = take'  hl xs
                  zs = drop' hl xs

-- and []
and' :: [Bool] -> Bool
and' [] = True
and' (x:xs) = x && and' xs

-- concat [[]] []
concat' :: [[a]] -> [a]
concat' [] = []
concat' (x:xs) = x `append'` concat' xs

-- replicate n a
replicate' :: Int -> a -> [a]
replicate' 0 _ = []
replicate' n x = x : replicate' (n-1) x

-- !! [a] n
index' :: [a] -> Int -> a
index' (x:_) 0 = x
index' (_:xs) n = index' xs (n-1)

-- elem
elem' :: Eq a => a -> [a] -> Bool
elem' _ [] = False
elem' x (y:ys) = (x == y) || elem' x ys
