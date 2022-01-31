module Main where

import qualified Firstlib as L

main :: IO ()
main = putStrLn (L.greet "i am demoB! from Ademo Firstlib and print nPr [1,2,3,4] 3") >> print  (L.nPr [1,2,3,4] 3) >> return ()
