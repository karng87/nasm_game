module Test_QuickCheck where

-- ghci -package-db /home/jkarng/.cabal/store/ghc-8.10.7/package.db -package hspec Addition.hs
import Test.Hspec

-- ghci -package-db /home/jkarng/.cabal/store/ghc-8.10.7/package.db -package QuickCheck -package hsepc Addition.hs
import Test.QuickCheck

-- Gen
trivialInt :: Gen Int
trivialInt = return 1

-- sample
sm :: IO()
sm = sample trivialInt

sm1 :: IO()
sm1 = sample $ return 1

-- sample'
sm' :: IO[Int]
sm' = sample' $ return 1

-- elements
sme :: [a] -> IO[a]
sme xs = sample' $ elements xs

my_property :: Int -> Bool
my_property x = x + 1 > x
runQc :: IO ()
runQc = quickCheck my_property

main :: IO ()
main = quickCheck $ \x -> x + 1 > (x::Int)

--main = hspec $ do
--  describe "Addition" $ do
--    it "1 + 1 is greater than 1" $ do
--      (1+1) > 1 `shouldBe` True
--    it "2 + 2 is 4" $ do
--      2+2 `shouldBe` 5
--    it "x+1 is always greater than x" $ do
--      property $ \x -> x+1 > (x ::Int)
--    it "x+1 is always greater than x+2" $ do
--      property $ \x -> x+1 > (x+2::Int)
--    it "given 2 lists of size A and B, there concatenation is size A+B" $ do
--      property $ \x y -> length (x::[Int]) + length (y::[Int]) == (length (x++y))


