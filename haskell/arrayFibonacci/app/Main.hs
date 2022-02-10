module Main where
import Data.Array (listArray, Array, array, Ix (inRange, rangeSize), accumArray, accum)

main :: IO ()
main =  do
  print $ take 10 fibsZipWidth
  print (fibsArr 10)
  print (fibslistArr 10)

fibsZipWidth :: [Integer]
fibsZipWidth = 1:1:zipWith (+) fibsZipWidth (tail fibsZipWidth)
-- 1:1:zipWith (+) [1,1,..] [1,..]
-- 1:1:(1+1):zipWith (+) [1,1,2,..] [1,2..]
-- 1:1:(1+1):(1+2)zipWith (+) [1,1,2,3..] [1,2,3..]
-- 1:1:(1+1):(1+2):(2+3)zipWith (+) [1,1,2,3,5..] [1,2,3,5..]

{- Calss Ix -}
-- range :: (a,a) -> [a]
--    range ('m','p') := "mnop"
-- index :: (a,a) -> a -> Int
--    index ('m','p') o := 2
-- inRange :: (a,a) -> a -> Bool
-- rangeSize :: (a,a) -> Int

{- listArray Function -}
-- Array Index Values
--   [(index, value)..]
--   listArray (index range) [values]
-- listArray :: Ix i => (i,i) -> [e] -> Array i e

listarr :: Array Char Integer
listarr = listArray ('m','p') [1..]

{- array Function -}
-- array :: Ix i => (i,i) -> [(i,e)] -> Array i e

arr :: Array Integer Char
arr = array (1,2) [(1, 'a'),(2,'d')]

{- (!) :: Ix i => Array i e -> i -> e -}
-- the value at the given i in an e array

{- bounds :: Ix i => Array i e -> (i,i) -}
-- the bounds with which an array was constructed

{- indices :: Ix i => Array i e -> [i] -}
-- the list of indices of an array in ascending order

{- elems :: Ix => Array i e -> [e] -}
-- the list of elements of an array in index order

{- assocs :: Ix i => Array i e -> [(i,e)] -}
-- the list of associtations of an array in index order

fibslistArr :: (Ix a, Enum a, Num a, Num e) => a -> Array a e
fibslistArr n = listArray (0,n) [f i| i <- [0..n]]
  where
    f 0 = 1
    f 1 = 1
    f i = f (i-1) + f(i-2)

fibsArr :: (Ix a, Enum a, Num a, Num e) => a -> Array a e
fibsArr n = array (0,n) [(i,f i)|i <- [0..n]]
  where
    f 0 = 1
    f 1 = 1
    f i = f (i-1) + f(i-2)

{- accumArray :: Ix i => (e -> a -> e) -> e -> (i, i) -> ([(i, a)]) -> Array i e -}
-- accum (+) 0 ('a','d') [('a',2),(a',3),('b',3),('c',4)]
--  := array ('a','d') [('a',5),('b',3),('c',4),('d',0)]
