module Btree where

data Btree a = Empty | Node a (Btree a) (Btree a) deriving Show

trL = Node "b" (Node "d" Empty Empty) (Node "e" Empty Empty)
trR = Node "c" (Node "f" Empty Empty) (Node "g" Empty Empty)
tr = Node "a" trL trR :: Btree String
tx = Node "x" tr tr
trr = Node "a" (Node "b" (Node "c" (Node "d" Empty (Node "f" Empty tx)) Empty) Empty) Empty

data ParentDir = PLeft | PRight | NoParent deriving (Show,Eq)
type ParentPos = Int
type Level = Int

tprint :: Show a => ParentDir -> [ParentPos] -> Level -> Btree a -> [String]
tprint _ _ _ Empty = []
tprint pd pp level (Node a l r) = undefined 
