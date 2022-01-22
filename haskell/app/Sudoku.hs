module Sudoku where

main :: IO ()
main = undefined

{- Choices :: Matrix [Char] <=> [[['1'],..,['9']],[[1],...[]],[[1],..[9]]]-}
{- Grid :: Matrix Char <=> [['1'],['2'],['.'],['4'],['5'],['.'],['7'],['.'],['9']] -}
{- Row Char :: [Char] <=> ['1','.','2'] <=> "1.2" -}
{- Value :: Char <=> '1' -}

type Choices = [Value]    --  [["123.342"]]
type Grid = Matrix Value  -- Matrix Char
type Matrix a = [Row a]   -- [ ['a','b','c',], "2.31"]
type Row a = [a]        -- "abc" == ['a','b','c']
type Value = Char       -- 'a'

easyM :: Matrix Int
easyM = [[3,7],4,[5,2]]

easyG :: Grid
easyG = [".7....6.","2"]

easyC :: Matrix [Char]
easyC = [["1.......9"],["2.........8"]]

easyP :: [Matrix Char]
easyP = []

blank :: Grid
blank = replicate 9 (replicate 9 '.')

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

-- TODO
--choices :: Grid -> Matrix Choices
--choices g = [map choice g]
--               where
--                 choice v = if v == '.' then ['1'..'9']
--                            else [v]

collapse :: Matrix [a] -> [Matrix a]
collapse m = undefined 

-- https://www.youtube.com/watch?v=O1-ruHzabAU&list=PLF1Z-APd9zK5uFc8FKr_di9bfsYv8-lbc&index=3
cp :: [[a]] -> [[a]]
cp [] = [[]] -- [] is not a $\emptyset$ but is the list type id
cp (xs:xss) = [y:ys | y <- xs, ys <- cp xss]
{- [ x | <- [] ] == [] -}
{- [ x | <- [[]] ] == [[]] -}

{- A basic solver -}
solve :: Grid -> [Grid]
solve = filter valid . collapse . choices

