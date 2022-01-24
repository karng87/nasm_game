module Main where
import qualified Ga.Lib as L
main :: IO ()
main = case L.greet "alice" of
          "Hello, Alice!" -> return ()
          s -> fail ("Unexpected greeting: " <> s)


