module Ga.Expr where
import Ga.Peano

data Expr = Val Int | Add Expr Expr | Mul Expr Expr
-- Val :: Int -> Expr
-- Add :: Expr -> Expr -> Expr
-- Mul :: Expr -> Expr -> Expr

size :: Expr -> Int
size (Val n) = 1
size (Add x y) = size x + size y
size (Mul x y) = size x + size y

eval :: Expr  -> Int
eval (Val n) = n
eval (Add x y) = eval x + eval y
eval (Mul x y) = eval x * eval y
