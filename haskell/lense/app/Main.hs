module Main where
import Data.List

data Foo = Foo {bar :: (Int, Int), baz :: Char}
instance Show Foo where
  show (Foo r z) = "Foo " <> show r <> " " <> show z

data Lense s a = Lense {view :: s -> a, set :: a -> s -> s}

barLense :: Lense Foo (Int,Int)
barLense = Lense bar (\x m -> m{bar=x})

getBar :: Foo -> (Int,Int)
getBar  = bar
setBar :: (Int, Int) -> Foo -> Foo
setBar x m = m{bar=x}

foo :: Foo
foo = Foo (1,2) 'c'

main :: IO ()
main = do
  print $ view (Lense bar (\x m -> m{bar=x})) (Foo (1,2) 'b')
  print $ set (Lense bar $ \x m -> m{bar=x}) (9,9) (Foo (1,2) 'b')
  print $ set (Lense bar (\x m -> m{bar=x})) (set (Lense snd (\x (i,_) -> (i,x))) 9 (1,2)) (Foo (1,2) 'a')
