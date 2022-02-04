module Lib2(add, sub) where

add :: Num a => a -> a -> a
add x y = x + y

sub:: Num a => a -> a -> a
sub x y = add x (neg y)

neg:: Num a => a -> a
neg x = -x
