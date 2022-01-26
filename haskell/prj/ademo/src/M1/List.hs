module M1.List where
import Prelude(Eq,Ord,Show(show),Bool(True,False),Int,Integer,(+),(*))

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
infinity = let inf x = x :. inf (x+1) in inf 0

foldRight :: (a->b->b) -> b -> List a -> b
foldRight _ i Nil = i
foldRight f i (x:.xs) = f x (foldRight f i xs)

foldLeft :: (b->a->b) -> b -> List a -> b
foldLeft _ i Nil = i
foldLeft f i (x:.xs) = foldLeft f (f i x ) xs 

headOr :: a -> List a -> a
headOr a Nil = a
headOr _ (x:._) = x

product :: List Int -> Int 
product = foldLeft (*) 1

sum :: List Int -> Int
sum = foldLeft (+) 0

length :: List a -> Int
length Nil = 0
length (_:.xs) = 1 + length xs

map :: (a -> b) -> List a -> List b
map _ Nil = Nil
map f (x:.xs) = f x :. map f xs 

filter :: (a -> Bool) -> List a -> List a
filter _ Nil = Nil
filter f (x:.xs) =
  if f x 
    then x :. filter f xs 
    else filter f xs  

(++) :: List a -> List a -> List a
(++) Nil ys = ys
(++) (x:.xs) ys = x:. (xs ++ ys)

infixr 5 ++

flatten :: List (List a) -> List a
flatten Nil = Nil
flatten (x:.xs) = x ++ flatten xs
