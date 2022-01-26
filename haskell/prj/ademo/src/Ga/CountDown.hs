module Ga.CountDown where
----------
-- Rule --
----------
-- Rule.1 
--    All the numbers, including intermediate results, must be positive natuals
-- Rule.2
--    Eah of the source numbers can be used at most once when constructing the expression.
-- Rule.3
--    We abstract from other rules that are adopted on television for pragmatic reasons.

-- Operators: 
data Op = Add | Sub | Mul | Div
apply :: Op -> Int -> Int -> Int
apply Add x y = x + y
apply Sub x y = x - y
apply Mul x y = x * y
apply Div x y = x `div` y

valid :: Op -> Int -> Int -> Bool
valid Add _ _ = True
valid Sub x y = x > y
valid Mul _ _ = True
valid Div x y = x `mod` y == 0

data Expr = Val Int | App Op Expr Expr

eval :: Expr -> [Int]
eval (Val n) = [n | n > 0]
eval (App o l r) = [apply o x y | x <- eval l, y <- eval r, valid o x y]

-- power set?
choices :: [a] -> [[a]]
split :: [a] -> [([a],[a])]

values :: Expr -> [Int]
values (Val n) = [n]
values (App _ l r) = values l ++ values r

solution :: Expr -> [Int] -> Int -> Bool
solution expr ns n = elem (values expr) (choices ns) && eval expr == [n]

combine :: Expr -> Expr -> [Expr]
combine l r = [App o l r | o <-[Add,Sub,Mul,Div]]

exprs :: [Int] -> [Expr]
exprs [] = []
exprs [n] = [Val n]
exprs ns = [expr | (ls, rs) <- split ns,
                , l <- express ls
                , r <- express rs
                , expr <- combine l r ]

solutions :: [Int] -> Int -> [Expr]
solutions ns n = [expr | ns' <- choices ns
                        , expr <- exprs ns'
                        , eval  expr == [n]]

 
 type Result = (Expr, Int)

 rcombine :: Result -> Result -> [Result]
 rcombine (l,x) (r,y) = [(App o l r, apply o x y) | o <- [Add,Sub,Mul,Div], valid o x y]

 results :: [Int] -> [Result]
 results [] = []
 results [n] = [(Val n,n) | n > 0]
 results ns = [ res | (ls,rs) <- split ns
                    , lx <- results ls
                    , ry <- results rs
                    , res <- rcombine lx ry]


