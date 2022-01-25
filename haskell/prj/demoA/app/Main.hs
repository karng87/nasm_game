module Main where

import qualified Mylib as L
import Data.Char
import System.Environment

toInt :: String -> Int
toInt xs =  read (take 1 (filter isDigit xs))::Int

main :: IO ()
-- main = getLine >>= \x -> if null x then do main else putStrLn . show . L.npr [1..4] $ toInt x
main = mapM_ (putStrLn . L.greet) =<< getArgs
