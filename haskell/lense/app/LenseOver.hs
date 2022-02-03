{-# LANGUAGE RankNTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}

module LenseOver where
data Foo = Foo {bar::(Int, Int), baz::Char} deriving (Show)
main :: IO ()
main = do
  print "==== Lense Over ===="
  print $ over (lense bar (\s a -> s{bar=a}) . lense snd (\(i,_) a -> (i,a))) (*3) (Foo (1,2) 'a')

type Lense s a = forall f. Functor f => (a -> f a) -> s -> f s
newtype Identity a = CIdentity {runIdentity::a}
newtype Const b a = CConst {runConst :: b}
instance Functor Identity where
  fmap f (CIdentity a) = CIdentity (f a)
instance Functor (Const b) where
  fmap _ (CConst b) = CConst b

lense :: (s -> a) -> (s -> a -> s) -> Lense s a
lense sa sas afa s = fmap (sas s) (afa (sa s))

over :: Lense s a -> (a -> a) -> s -> s
over l f s = runIdentity (l (CIdentity . f) s)
