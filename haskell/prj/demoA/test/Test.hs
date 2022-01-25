module Main where

import Mylib
main :: IO ()
main = 
  case greet "alice" of
    "Hello Alice!" -> return ()
    s -> fail ("Unexpected greeting: " <> s)
