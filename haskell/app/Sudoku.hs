module Sudoku where

main :: IO ()
main = undefined

{- basic declarations -}
type Grid = Matrix Value
type Matrix a = [Row a]
type Row a = [a]
type Value = Char

easy :: Grid
easy = ["2....1.38",
        "........5",
        "........5",
        "........5",
        "........5",
        "........5",
        "........5",
        "........5",
        ".7...6..."]

blank :: Grid
blank = replicate 9 (replicate 9 '.')

{- Functons -}
{- rows, clos, boxs :: Matrix a -> [Row a] -}
{- valid :: Grid -> Bool -}
{- Properties -}
{- rows . rows = id -}
{- cols . cols = id -}
{- boxs . boxs = id -}

rows :: Matrix a -> [Row a]
--rows m = m
rows = id
-- Property: rows . rows = id

cols :: Matrix a -> [Row a]
cols  = undefined
-- Property: cols . cols = id

boxs :: Matrix a -> [Row a]
boxs =  undefined
-- Property: boxs . boxs = id

valid :: Grid -> Bool
valid g = all' nodups (rows g) &&
          all' nodups (cols g) &&
          all' nodups (boxs g)

all' :: (a->Bool) -> [a] -> Bool
all' p xs = and [p x | x <- xs]

nodups :: Eq a => [a] -> Bool
nodups [] = True
nodups (x:xs) = not (elem x xs) && nodups xs

{- A basic solver -}
{- makeing choies -}
type Choices = [Value]

choices :: Grid -> Matrix Choices
choices g = map (map choice) g
                      where
                        choice v = if v == '.' then ['1'..'9']
                                   else [v]

collapse :: Matrix [a] -> [Matrix a]
collapse = undefined

-- https://www.youtube.com/watch?v=O1-ruHzabAU&list=PLF1Z-APd9zK5uFc8FKr_di9bfsYv8-lbc&index=3
cp :: [[a]] -> [[a]]
cp [] = [[]]
cp (xs:xss) = [y:ys | y <- xs, ys <- cp xss]
