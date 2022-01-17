module Main where

import qualified Lib

main :: IO ()
main = putStrLn (show $ Lib.pset [1..3]) 
