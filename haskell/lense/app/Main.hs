module Main where
import Data.List (delete)
{- 
($) :: (a->b) -> (a->b)
f $ g x = f (g x)
-}
{- 
s := stuff 
a := magnitude stuf
{} \iff record update notation
-}
data Foo = Foo {bar :: (Int, Int), baz :: Char} 
-- {} is record notation 
-- view /iff  bar Foo or baz Foo
-- update /iff Foo{bar=(new)}

mytuple :: (Int,Int)
mytuple = (1,2)
myfoo :: Foo
myfoo = Foo mytuple 'c'
foo = myfoo{bar = (10,20)}

data Lense s a = Lense {get :: s -> a, set :: s -> a -> s}

instance Show Foo where
  show (Foo (i,j) c)=  "(" <> show i <> "," <> show j <> ") " <> show c -- = print Foo (3,4) 'cc

barL :: Lense Foo (Int,Int)
barL = Lense bar $ \m x -> m{bar=x}

barL' = Lense getbar setbar
getbar :: Foo -> (Int,Int)
getbar = bar
setbar :: Foo -> (Int,Int) -> Foo
setbar f r = f{bar=r}

bar2L :: Lense (Int,Int) Int
bar2L = Lense snd $ \(i,_) j' -> (i,j')

bar2L' = Lense get_2 set_2
get_2 :: (Int,Int) -> Int
get_2 (_,j) = j
set_2 :: (Int,Int) -> Int -> (Int, Int)
set_2 (i,_) j' = (i,j')

main :: IO ()
main = do
  print $ get barL foo
  print $ set barL foo (5,5)
  print $ get bar2L mytuple
  print $ set bar2L mytuple 10
