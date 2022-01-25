module Tmp where

main :: IO ()
main = putStrLn "put a char:" >> (getChar >>= \c -> if c /= ' ' then putChar c >> main else putStrLn "A.txt" >> writeFile "A.txt" "Hi A.txt")

{- return :: a -> m a -}
{- pure :: a -> f a -}
{- pure () >>= pure main \iff pure () >>= \_ -> main -}
{- return() >>= return main \iff return() >>= \_ -> main -}
