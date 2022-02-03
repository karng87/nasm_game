{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}

module LenseMultiple where
data Foo = Foo {bar::(Int,Int), baz::Char} deriving (Show)
main :: IO ()

main = do
  print "=== Lense Multiple ==="
  print $ set (lense snd (\(i,_) a -> (i,a))) 'a' (1,2)
  print $ set (lense bar (\foo a -> foo{bar=a})) (8,9) (Foo (1,2) 'a')
  print $ over (lense snd (\(i,_) a -> (i,a))) show (1,2)

type Lense s t a b = forall f. Functor f => (a -> f b) -> s -> f t
type Lense' s a = Lense s s a a

newtype Const b a = CConst {runCConst :: b}
newtype Identity a =  CIdentity {runCIdentity :: a}
instance Functor Identity where
  fmap f (CIdentity a) = CIdentity (f a)
instance Functor (Const b) where
  fmap _ (CConst b) = CConst b

lense :: (s -> a) -> (s -> b -> t) -> Lense s t a b
lense sa sbt afb s = fmap (sbt s) (afb (sa s))
view :: Lense s t a b -> s -> a
view l s = runCConst (l CConst s)
set :: Lense s t a b -> b -> s -> t
set l b t = runCIdentity (l (const (CIdentity b)) t)
over :: Lense s t a b -> (a -> b) -> s -> t
over l f s = runCIdentity (l (CIdentity . f) s)
