{-#LANGUAGE RankNTypes #-}
module Main where

main :: IO ()
main = do
  print $ set1 (Lense1 tuple (\ij foo -> foo{tuple=ij})) (9,9) (CFoo (1,1) 'a')
  print $ set1 (Lense1 snd (\j (i,_) -> (i,j))) 8 (2,2) 
  print $ set1 (compose1 (Lense1 tuple (\ij foo -> foo{tuple=ij})) (Lense1 snd (\j (i,_) -> (i,j)))) 7 (CFoo (3,3) 'a')
  print $ view1 (modify1 (Lense1 tuple (\ij foo -> foo{tuple=ij})) (\(i,j) -> (i*i,j*j) )) (CFoo (3,3) 'a')
  print $ modify (Lense2 tuple (\ij foo -> foo{tuple=ij}) (\f foo -> foo{tuple=f (tuple foo)})) (\(i,j) -> (i*i,j*j)) (CFoo (3,3) 'a')

data Lense1 s a = Lense1 {view1 :: s -> a, set1 :: a -> s -> s}
compose1 :: Lense1 s a -> Lense1 a a'  -> Lense1 s a'
compose1 (Lense1 v1f s1f) (Lense1 v2f s2f) = Lense1 (\s -> v2f (v1f s)) (\a s -> s1f (s2f a (v1f s)) s)
modify1 :: Lense1 s a -> (a -> a) -> Lense1 s a
modify1 (Lense1 vf sf) f = Lense1 (f . vf) (\a s -> sf (f . vf $ s) s)

data Lense2 s a = Lense2 {view2 :: s -> a,set2 :: a -> s -> s ,modify :: (a -> a) -> s -> s}
type Lense' s a = forall f. Functor f => (a -> f a) -> s -> s

data Foo = CFoo {tuple::(Int,Int), char::Char}
instance Show Foo where
  show f = show (tuple f) <> show (char f)
