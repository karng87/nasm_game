module Lib(someFunc) where

--import Lib2 (add)
import Test.QuickCheck(quickCheck)
import Test.TypeSpec(

someFunc :: IO ()
someFunc = quickCheck prop_reverse
--someFunc = putStrLn $ "1+1= " ++ show (add 1 1)
--error ?? someFunc = quickCheck (\xs -> reverse . reverse $ xs) `shouldBe` xs

prop_reverse :: [Int] -> Bool
prop_reverse xs = reverse (reverse xs) == xs
