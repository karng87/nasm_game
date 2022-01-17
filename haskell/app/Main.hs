module Main where

import qualified Lib
import Data.Char
main :: IO ()
main = do  
      print "put numbers:"
      arr <- getLine
      print (Lib.pset $ map (\x->read [x]::Int) (filter isDigit arr)) 
