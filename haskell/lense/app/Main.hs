module Main where
main :: IO ()
main = do
  print "=============="
  print $ view (CLense (\(i,j) -> j) (\a (i,_) -> (i,a)) (undefined )) (1,2)
  print $ set (CLense (\(i,j) -> j) (\a (i,_) -> (i,a)) (undefined )) 3 (1,2)
  print $ over (CLense (\(i,j) -> j) (\a (i,_) -> (i,a)) (\f (i,j) -> (f i, f j))) (+3) (1,1)
  print "=============="
  print $ view (CLense baz (\a s -> s{baz=a}) (undefined )) (CFoo (1,1) 'a')
  print $ set (CLense bar (\a s -> s{bar=a}) (undefined )) (2,2) (CFoo (1,1) 'a')
  print $ over (CLense bar (\a s -> s{bar=a}) (\f (CFoo l r) -> CFoo (f l) r )) (\(i,j)->(i*4,j*3)) (CFoo (1,1) 'a')

data Foo = CFoo {bar::(Int,Int),baz::Char}
instance Show Foo where
  show f = "Foo " <> show (bar f) <> show (baz f)
data Lense s a = CLense {view :: s -> a, set:: a -> s -> s, over:: (a->a) -> s -> s}
