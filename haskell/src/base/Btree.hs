module Btree where

data Btree a = Leaf a | Node a (Btree a) (Btree a) deriving Show

tr :: Btree Integer;
tr = Node 1 (Leaf 2) (Leaf 3)

allPath :: Btree a -> [[a]]
allPath (Leaf a) = [[a]]
allPath (Node a l r) = (a:) <$> allPath l ++ allPath r
