module Tmp where

main :: IO ()
main = do putStrLn "put a char:" 
       >>= \_ -> getChar 
       >>= \c -> if c /= ' ' 
         then putChar c  
           >>= \_ -> main
         else putStrLn "A.txt" 
           >>= \_ -> writeFile "A.txt" "Hi A.txt" 
           >>= return

{- return :: a -> m a -}
{- pure :: a -> f a -}
{- pure () >>= pure main \iff pure () >>= \_ -> main -}
{- return() >>= return main \iff return() >>= \_ -> main -}
