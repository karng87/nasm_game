{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}

module LIdentity where
main :: IO ()
main = do
  print "=== Lense set Identity ==="
  print $ set (lense (\(_,j) -> j) (\(i,_) a -> (i,a))) 2 (1 :: Integer,1 :: Integer)
  print $ set (lense (\foo -> bar foo) (\foo a -> foo{bar=a})) (3,4) (CFoo (1,2) 'a')
  print $ set (lense bar (\foo a -> foo{bar=a}) . lense snd  (\(i,_) a -> (i,a))) 2 (CFoo (1,1) 'a')
  print "=== Lense view Identity ==="
  print $ view (lense snd (\(i,_) a -> (i,a))) (1::Integer ,2::Integer)
  print $ view (lense bar (\s a -> s{bar=a})) (CFoo (1,2) 'a')
  print $ view (lense baz (\s a -> s{baz=a})) (CFoo (1,2) 'a')

data Foo = CFoo {bar::(Int,Int), baz::Char}
instance Show Foo where
  show (CFoo l c) = "CFoo " <> show l <> show c

type Lense s a = forall f. Functor f => (a -> f a) -> s -> f s
lense :: (s -> a) -> (s -> a -> s) -> Lense s a
lense sa sas afa s =  fmap (sas s) (afa (sa s))

newtype LIdentity a  = CLIdentity {runCLIdentity :: a}
instance Functor LIdentity where
  fmap f (CLIdentity a) = CLIdentity (f a)

set :: Lense s a -> a -> s -> s
set l a s = runCLIdentity (l (const (CLIdentity a)) s) -- l == Lense sa sas -- const a _ = a  -- const id x = id => cost id _ = id
{- 
  l \iff Lense sa sas 
  \therefore l (a-> fa) s \to fs
  \iff Lense sa sas (a->a) s
-}
newtype Const b a = CConst {runCost :: b}
instance Functor (Const b) where
  fmap _ (CConst b) = CConst b

view :: Lense s a -> s -> a
view l s = runCost (l CConst s)
