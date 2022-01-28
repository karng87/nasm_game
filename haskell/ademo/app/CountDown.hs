module CountDown where

import System.IO
import System.CPUTime
import Numeric
import Data.List -- delete

main :: IO ()
main =  do 
  hSetBuffering stdout NoBuffering
  putStrLn "\nCOUNTDOWN NUMBERS GAME SOLVER"
  putStrLn "-----------------------------\n"
  putStr "Enter the given numbers : "
  ns <- readLn
  putStr "Enter the target number : "
  n  <- readLn
  display (solutions'' ns n)

-- Arithmetic operators

data Op = Add | Sub | Mul | Div
op1 :: Op
op1 = Div

data Expr = Val Int | App Op Expr Expr
expr1 :: Expr
expr1 = App Add (App Mul (App Div (Val 6)(Val 3)) (App Sub (Val 8)(Val 2))) (App Sub (Val 9)(Val 3))
expr2 = App Add (App Mul (App Div (Val 6)(Val 3)) (App Sub (Val 8)(Val 2))) (App Sub (Val 3)(Val 9))

instance Show Op where
   show Add = "+"
   show Sub = "-"
   show Mul = "*"
   show Div = "/"

instance Show Expr where
  show (Val n)    = show n
  show (App o l r)= wh l ++ show o ++ wh r where -- op :: infix binary operators
                    wh (Val n) = show n  -- show :: a -> [Char]
                    wh expr = "(" ++ show expr ++ ")"

-- all Expr > 0 && natural number
valid :: Op -> Int -> Int -> Bool
valid Add _ _ = True
valid Sub x y = x > y
valid Mul _ _ = True
valid Div x y = x `mod` y == 0

values :: Expr -> [Int]
values (Val n) = [n]
values App o l r = values l >>= \l' -> values r >>= \r' -> return l' ++ r'
-- values (App _ l r) = values l ++ values r

-- TODO unknown action
--values (App _ l r) = values l >>= \l' -> values r  >>= \r' -> [0,l',r',9]

-- div \iff all args \in \mathbb N
apply :: Op -> Int -> Int -> Int
apply Add x y = x + y
apply Sub x y = x - y
apply Mul x y = x * y
apply Div x y = x `div` y

eval :: Expr -> [Int]
eval (Val n)     = [n | n > 0]
eval (App op l r) = eval l >>= \l' -> eval r >>= \r' -> [valid op l' r'] >>= \v -> if v then [apply op l' r'] else []
-- eval (App op l r) = [apply op l' r' | l' <- eval l, r' <- eval r, valid op l' r']
-- eval (App op l r) = zipWith (apply op) (eval l) (eval r)

-- Combinatial functions
subs :: [a] -> [[a]]
subs []     = [[]]
subs (x:xs) = subs xs ++ map (x:) (subs xs) -- = yss ++ map (x:) yss where yss = subs xs

bsubs :: [a] -> [[a]]
bsubs [] = [[]]
bsubs (x:xs) = bsubs xs >>= \x' -> [x'] ++ [x : x']

-- nPr = permutation $ _nP_r = \frac{n!}{(n-r)!}$
permutation :: Eq a => [a] -> [[a]]
permutation []  = [[]]
permutation (x:xs)  =  


--permutation np r = np >>= (\x -> (x:) <$> permutation (delete x np) (r-1))

-- power set 2^{n}
powerset :: [a] -> [[a]]
powerset [] = [[]]
powerset (n:ns) =  powerset ns  ++  map (n:) (powerset ns)
-- powerset (n:ns) =  powerset ns  ++  ((n:) <$> powerset ns)

-- nCr = Combination $ _nC_r = \frac{_nP_r}{r!}$
combination :: [a] -> Int -> [[a]]
combination _ 0 = [[]] 
combination n r = take r $ powerset n 

-- 사이 사이 끼워넣기
interleave :: a -> [a] -> [[a]]
interleave x []     = [[x]]
interleave x (y:ys) = (x:y:ys) : map (y:) (interleave x ys)

perms :: [a] -> [[a]]
perms []     = [[]]
perms (x:xs) = concat $ map (interleave x) (perms xs)
-- perms (x:xs) = perms xs >>= interleave x

choices :: [a] -> [[a]]
choices = concat . map perms . powerset 
-- concat . map perms . subs
-- concat . map perms . subs $ xs
-- (.) concat ((.) (map perms) powerset) xs
-- .      => infix function
-- (.)    => prefix function
-- map    => prefix fucntion
-- `map`  => infic function


-- Formalising the problem

solution :: Expr -> [Int] -> Int -> Bool
solution e ns n = elem (values e) (choices ns) && eval e == [n]

-- Brute force solution
--    (x,y) : [] => [(x,y)]
--    map (\(x,y) -> (3:x , y)) [] => []
split :: [a] -> [([a],[a])]
split []     = []
split [_]    = []
split (x:xs) = ([x],xs) : [(x:ls,rs) | (ls,rs) <- split xs]
-- [(3:x,y) | (x,y) <- []] == []

exprs :: [Int] -> [Expr]
exprs []  = []
exprs [n] = [Val n]
exprs ns  = [e | (ls,rs) <- split ns,
                 l       <- exprs ls,
                 r       <- exprs rs,
                 e       <- combine l r]

combine :: Expr -> Expr -> [Expr]
combine l r = [App o l r | o <- ops]

ops :: [Op]
ops = [Add,Sub,Mul,Div]

solutions :: [Int] -> Int -> [Expr]
solutions ns n = [e | ns' <- choices ns, e <- exprs ns', eval e == [n]]

-- Combining generation and evaluation

type Result = (Expr,Int)

results :: [Int] -> [Result]
results []  = []
results [n] = [(Val n,n) | n > 0]
results ns  = [res | (ls,rs) <- split ns,
                      lx     <- results ls,
                      ry     <- results rs,
                      res    <- combine' lx ry]

combine' :: Result -> Result -> [Result]
combine' (l,x) (r,y) = [(App o l r, apply o x y) | o <- ops, valid o x y]

solutions' :: [Int] -> Int -> [Expr]
solutions' ns n = [e | ns' <- choices ns, (e,m) <- results ns', m == n]

-- Exploiting algebraic properties

valid' :: Op -> Int -> Int -> Bool
valid' Add x y = x <= y
valid' Sub x y = x > y
valid' Mul x y = x /= 1 && y /= 1 && x <= y
valid' Div x y = y /= 1 && x `mod` y == 0

results' :: [Int] -> [Result]
results' []  = []
results' [n] = [(Val n,n) | n > 0]
results' ns  = [res | (ls,rs) <- split ns,
                       lx     <- results' ls,
                       ry     <- results' rs,
                       res    <- combine'' lx ry]

combine'' :: Result -> Result -> [Result]
combine'' (l,x) (r,y) = [(App o l r, apply o x y) | o <- ops, valid' o x y]

solutions'' :: [Int] -> Int -> [Expr]
solutions'' ns n = [e | ns' <- choices ns, (e,m) <- results' ns', m == n]

-- Performance testing

showtime :: Integer -> String
showtime t = showFFloat (Just 3) (fromIntegral t / (10^12)) " seconds"

display :: [Expr] -> IO ()
display es = do t0 <- getCPUTime
                if null es then
                   do t1 <- getCPUTime
                      putStr "\nThere are no solutions, verified in "
                      putStr (showtime (t1 - t0))
                      putStr ".\n\n"
                else
                   do t1 <- getCPUTime
                      putStr "\nOne possible solution is "
                      putStr (show (head es))
                      putStr ", found in "
                      putStr (showtime (t1 - t0))
                      putStr "\n\nPress return to continue searching..."
                      getLine
                      putStr "\n"
                      t2 <- getCPUTime
                      if null (tail es) then
                         putStr "There are no more solutions"
                      else
                         do sequence [print e | e <- tail es]
                            putStr "\nThere were "
                            putStr (show (length es))
                            putStr " solutions in total, found in "
                            t3 <- getCPUTime
                            putStr (showtime ((t1 - t0) + (t3 - t2)))
                            putStr ".\n\n"
  
