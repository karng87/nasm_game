module Main where
import Data.List

data Foo = Foo {bar :: (Int, Int), baz :: Char}
instance Show Foo where
  show (Foo r z) = "Foo " <> show r <> " " <> show z

-- s := a structure
-- a := a value in the structure
-- data Lense s a = Lense {view :: s -> a, set :: a -> s -> s}
data Lense s a = Lense (s -> a) (a -> s -> s)
view :: Lense s a -> s -> a
view (Lense sa ass) s = sa s  
set :: Lense s a -> a -> s -> s
set (Lense sa ass) a s  = ass a s

type Lense' s a = (a -> a) -> s -> s
lense' :: (s -> a) -> (s -> a -> s) -> Lense' s a
lense' sa sas aa s =  sas s $ aa (sa s)

set' :: Lense' s a -> a -> s -> s
set' l a s = l (const a) s

--view' :: Lense' s a -> s -> a
--view' l s = l s

main :: IO ()
main = do
  print $ set' ((lense' bar  (\m x -> m{bar=x})) . (lense' (\(_,j)-> j) (\(i,_) j' ->(i,j')))) 9  (Foo (1,2) 'c')
  print $ set' ((lense' baz  (\m x -> m{baz=x})) . (lense' (\i -> i) (\i j -> j ))) 'f'  (Foo (1,2) 'c')
