module Main where

main :: IO ()
main = do
  print $ set (Lense tuple (\ij foo -> foo{tuple=ij})) (9,9) (CFoo (1,1) 'a')
  print $ set (Lense snd (\j (i,_) -> (i,j))) 8 (2,2) 
  print $ set (composeL (Lense tuple (\ij foo -> foo{tuple=ij})) (Lense snd (\j (i,_) -> (i,j)))) 7 (CFoo (3,3) 'a')
  print $ view (modify (Lense tuple (\ij foo -> foo{tuple=ij})) (\(i,j) -> (i*i,j*j) )) (CFoo (3,3) 'a')
  print $ set (modify (Lense tuple (\ij foo -> foo{tuple=ij})) (\(i,j) -> (i*i,j*j) )) (1,3) (CFoo (3,3) 'a')

data Lense s a = Lense {view :: s -> a 
                       ,set :: a -> s -> s}

composeL :: Lense s a -> Lense a a'  -> Lense s a'
composeL (Lense v1f s1f) (Lense v2f s2f) = Lense (\s -> v2f (v1f s)) (\a s -> s1f (s2f a (v1f s)) s)

modify :: Lense s a -> (a -> a) -> Lense s a
modify (Lense vf sf) f = Lense (f . vf) (\a s -> sf (f . vf $ s) s)

data Foo = CFoo {tuple::(Int,Int), char::Char}
instance Show Foo where
  show f = show (tuple f) <> show (char f)
