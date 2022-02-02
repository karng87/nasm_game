{-# LANGUAGE Rank2Types #-}

module Main where

main :: IO ()
main = putStrLn "rank2 :: ([a] -> Int) -> [b] -> [c] -> Bool \n rank2 f b c = f b == f c {-error-}"

-- rank1 :: forall a b c. [a]->Int -> [b] -> [c] -> Bool
-- error Rank 1 type
-- rank1 :: forall b c. (forall a. [a]->Int) -> [b] -> [c] -> Bool
-- rank1 fai mb mc = fai mb == fai mc 

rank2 :: (forall a. [a]->Int) -> [b] -> [c] -> Bool
rank2 f b c = f b == f c

type Lense s a = forall f. Functor f => (a -> f a) -> s -> f s
