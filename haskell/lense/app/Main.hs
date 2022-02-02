{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
module Main where
import Data.Functor.Identity (Identity(Identity))

main :: IO ()
main = do
  --print $ set (lense tuple (\ij foo -> foo{tuple=ij})) (9,9) (CFoo (1,1) 'a')
  --print $ view1 (lense char (\c foo -> foo{char=c})) (CFoo (1,1) 'a')
  --print $ set (lense snd (\j (i,_) -> (i,j))) 8 (2,2) 
  --print $ set (lense char (\a s -> s{char=a})) 'k' (CFoo (1,1) 'a')
  --print "=== Conpostiton ===="
  --print $ set (lense tuple (\a s -> s{tuple =a}) . (lense snd (\j (i,_) -> (i,j))) ) 8 (CFoo (1,1) 'a')
  print "========================"
  print $ set ( lense (tuple) (\s a -> s{tuple =a}) . lense snd (\(i,_) j -> (i,j)) ) 8 (CFoo (1,1) 'a')

-------------------------------
-- s: structure a: attribute --
-------------------------------
data Foo = CFoo {tuple::(Int,Int), char::Char}
instance Show Foo where
  show f = show (tuple f) <> show (char f)

------------
-- Lense1 --
------------
type Lense s a = forall f. Functor f => (a -> f a) -> s -> f s
lense :: (s -> a) -> (s -> a -> s) -> Lense s a
lense sa ass afa s =  ass s <$> afa (sa s)

newtype Identity' a = Identity' {runIdentity' :: a}
instance Functor Identity' where
  fmap f (Identity' a) = Identity' (f a)

set :: Lense s a -> a -> s -> s
set l a s  = runIdentity' $ l (const (Identity' a)) s  -- a -> f a

newtype Const b a = Const{runConst:: b}
instance Functor (Const b) where
  fmap _ (Const b) = Const b -- 스트럭쳐(s) 무시하고 속성(a)만 취하는 신의 한수

view :: Lense s a -> s -> a 
view l s = runConst $ l Const s  -- l \equiv Lense s a :: l afa s therfore how to get (a -> f a) and then return a

------------
-- Lense2 --
------------
type Lense2 s a = (a -> a) -> s -> s
