module M1.List where
import Prelude(Eq,Ord,Show,Bool (False, True),Int,(<=),(+),(-),(*), Integer, const, (.), flip, (&&))
import M1.Optional

data List t = Nil | t :. List t deriving (Eq,Ord,Show) -- t :. List t


infixr 5 :.
{- associativity -}
-- in the same operator precedence
{- right associativity -}
-- 1 :. 3 :. 5 => 1 :. (3 :. 5)
-- left associativity 
-- 1 :. 3 :. 5 => (3 :. 5) :. 1)
{- precedence 5 -}
-- in the different operator types

infinity :: List Integer
infinity = let inf x = x :. inf (x+1) in inf 1

takeList :: Int -> List Integer -> List Integer
takeList _ Nil = Nil
takeList n (x:.xs) = if n <= 0 then Nil else x:. takeList (n-1) xs

foldRight :: (a->b->b) -> b -> List a -> b
foldRight _ acc Nil = acc  -- 중요중요
foldRight f acc (x:.xs) = f x (foldRight f acc xs)

foldLeft :: (b->a->b) -> b -> List a -> b
foldLeft _ acc Nil = acc  -- 중요중요
foldLeft f acc (x:.xs) = foldLeft f (f acc x ) xs

headOr :: a -> List a -> a
--headOr a xs  = foldRight (\x' y' -> x') a xs
headOr  = foldRight const

product :: List Int -> Int
product = foldLeft (*) 1

sum :: List Int -> Int
sum = foldLeft (+) 0

length :: List a -> Int
--length = foldLeft (\x y -> x + 1 ) 0 
length = foldLeft (const . (+1)) 0
--length Nil = 0
--length (_:.xs) = 1 + length xs

map :: (a -> b) -> List a -> List b
map f = foldRight (\x y -> f x :. y ) Nil
--map _ Nil = Nil 
--map f (x:.xs) = f x :. map f xs 

filter :: (a -> Bool) -> List a -> List a
filter f = foldRight(\x y -> (if f x then x :. y else y)) Nil
--filter f = foldRight(\x -> (if f x then (x :.) else id) Nil

--filter _ Nil = Nil
--filter f (x:.xs) =
--  if f x 
--    then x :. filter f xs 
--    else filter f xs  

(++) :: List a -> List a -> List a
--(++) xs ys = foldRight (:.) ys xs 
(++) = flip (foldRight (:.))
--(++) Nil ys = ys
--(++) (x:.xs) ys = x:. (xs ++ ys)

infixr 5 ++

flatten :: List (List a) -> List a
flatten  = foldRight (++) Nil
--flatten Nil = Nil
--flatten (x:.xs) = x ++ flatten xs

{- 중요 -}
flatMap :: (a->List b) -> List a -> List b
flatMap f = foldRight (\x y -> f x ++ y) Nil
--flatMap _ Nil = Nil
--flatMap f (x:.xs) = f x ++ flatMap f xs

-- Full 1 :. Full 2:. Empty :. Full 3 :. Nil
-- Full 1:.2:.3:.Nil

seqOptional :: List (Optional a) -> Optional (List a)
seqOptional = foldRight (applyOptional . mapOptional (:.)) (Full Nil)

--  ======================================================>
-- 
-- setOptional = List(Optional a) => (Optional List a)
-- setOptional = foldRight || Full(a:.Nil)) || (Full Nil) (Full a)
-- setOptional = foldRight || Full(:.) 1.(Full a) 2.(Full Nil)) || 2.(Full Nil) 1.List(Full a)
-- setOptional = foldRight || Full(:.) || 2.(Full Nil) 1.List(Full a)
-- setOptional = foldRight || applyOptional Full(:.) Full a || 2.(Full Nil) 1.List(Full a)
-- setOptional = foldRight || applyOptional Full(a:.) || 2.(Full Nil) 1.List(Full a)
-- setOptional = foldRight || applyOptional Full(a:.Nill) || 2.(Full Nil) 1.List(Full a)
-- setOptional = foldRight || applyOptional Full(:.) || 2.(Full Nil) 1.List(Full a)
-- setOptional = foldRight || applyOptional . mapOptional (:.) || 2.(Full Nil) 1.List(Full a)
-- setOptional = foldRight || applyOptional . Full (a:.) 1 || 2.(Full Nil)
-- setOptional = foldRight || Full (a:.Nil) 1 , 2||
-- 
--  ================================================

-- optional a :. Full Nil
--seqOptional xs = if chkEmpty xs then foldRight (\(Full a) (Full b) -> Full (a :. b)) (Full Nil) xs else Empty
--  where
--    chkEmpty :: List (Optional a) -> Bool
--    chkEmpty Nil = True
--    chkEmpty (Empty:._) = False
--    chkEmpty (_:.ws) = chkEmpty ws

--seqOptional = foldRight (\x' y' -> x' `adjFn` y') (Full Nil)
--  where
--    adjFn :: Optional a -> Optional (List a) -> Optional (List a)
--    adjFn Empty     _         = Empty 
--    adjFn _         Empty     = Empty
--    adjFn (Full x)  (Full y)  = Full (x:.y)

find :: (a -> Bool) -> List a -> Optional a
find f = foldRight (\x y -> if f x then Full x else y) Empty
-- find _ Nil = Empty
-- find f (x:.xs) = if f x then Full x else find f xs

reverse :: List a -> List a
reverse = foldLeft (flip (:.)) Nil
-- reverse Nil = Nil
-- reverse xs = foldLeft (\x y -> y :. x) Nil xs

produce :: (a -> a) -> a -> List a
produce f x = x:. produce f (f x)

-- end of List

hlist :: List a -> [a]
hlist = foldRight (\x y -> x : y) []

{- nPr -}
pumutation :: List a -> List (List a)
pumutation = Nil:.Nil:.
