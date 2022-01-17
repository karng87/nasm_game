module Main where

import qualified Ga.Lib as L
import Data.Char
main :: IO ()
main = do  
      print "put numbers:"
      arr <- getLine
      print (L.pset $ map (\x->read [x]::Int) (filter isDigit arr)) 
