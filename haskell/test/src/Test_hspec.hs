module Test_hspec where

-- ghci -package-db /home/jkarng/.cabal/store/ghc-8.10.7/package.db -package hspec Addition.hs
import Test.Hspec

main :: IO ()
main = hspec $ do
  describe "Addition" $ do
    it "1 + 1 is greater than 1" $ do
      (1+1) > 1 `shouldBe` True
    it "2 + 2 is 4" $ do
      2+2 `shouldBe` 5

sayHello :: IO ()
sayHello = putStrLn "hello"
