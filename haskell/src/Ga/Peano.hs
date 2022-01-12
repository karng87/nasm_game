module Ga.Peano where

data Nat = Zero | Succ Nat deriving (Show)

int2nat :: Int -> Nat
int2nat 0 = Zero
int2nat i = Succ (int2nat (i-1))

nat2int :: Nat -> Int
nat2int Zero = 0
nat2int (Succ n) = 1 + (nat2int n)

add :: Nat -> Nat -> Nat
add Zero n  = n
add (Succ m) n = Succ (add m n)

mult :: Nat -> Nat -> Nat
mult n Zero = Zero
mult n (Succ m) = add n (mult n m)
-- mult (Succ n) m = (add (add (add (ad n n) n))) 
-- mult (Succ n) m = (add (add (add (ad m m) m))) 
