module Fibonacci where

fibs:: [Int]
fibs= 0 : 1 : zipWith (+) fibs (tail fibs)
