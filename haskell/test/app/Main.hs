module Main where

--import Test.Hspec
--import Text.QuickCheck
import qualified Test_QuickCheck as Qc

main :: IO ()
main = Qc.runQc
