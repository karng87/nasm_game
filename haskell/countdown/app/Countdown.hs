module Countdown where
import Control.Monad

main :: IO ()
main = do
  putStrLn "give me a list [Int]"
  ns <- readLn ::IO[Int]
  putStrLn "give me a Int as the result Int"
  n <- readLn
  display $ results ns n

display :: [Result] -> IO()
display = print

data Op = Add | Sub | Mul | Div deriving (Show)
data Expr = Val Int | App Op Expr Expr
e1 :: Expr
e1 = App Add (App Sub (Val 1) (App Div (Val 4) (Val 2))) (App Mul (App Sub (Val 6) (Val 2)) (App Add (Val 9) (Val 7)))
e2 :: Expr
e2 = App Add (Val 2) (App Mul (App Sub (Val 6) (Val 2)) (App Add (Val 9) (Val 7)))

instance Show Expr where
  show (Val n)= show n
  show (App o l r) =  case o of Add -> "(" <> show l <> "+" <> show r <> ")"; Sub -> "(" <> show l <> "-" <> show r <> ")"; Mul -> "(" <> show l <> "*" <> show r <> ")"; Div -> "(" <> show l <> "/" <> show r <> ")"

eval :: Expr -> Int
eval (Val n) = n
eval (App o l r) = case o of Add -> eval l + eval r; Sub -> eval l - eval r ; Mul -> eval l * eval r; Div -> eval l `div` eval r 

type Result = (Expr, Int)

-- ns 를 쪼개기 :: 만들수 있는 자리수 쌍 구하기
split :: [a] -> [([a],[a])]
split [] = [] -- ([],[])
split [_]= [] -- ([],[])
split (x:xs) = [([x],xs)] ++ (fmap (\(i,j)-> (x:i,j)) $ split xs)

-- 쪼갠 ns의 쌍으로 만들수 있는 조합 구하기 :: 순열이 아닌 이유는 ns를 중복해서 사용하지 않는 조건
-- combination nCr :: 구하기 전에 powersets 먼저 구함
nCr :: [a] -> Int -> [[a]]
nCr ns r = filter (\x -> length x == r) $ powersets ns

powersets :: [a] -> [[a]]
powersets [] = [[]] -- if [] then fmap (x:) [] == [] ::: fmap (x:) [[]] == [[x]]
-- powersets [3] = [[3],[]]
-- powersets [2,3] = [[2,3],[2],[3],[]]
powersets (x:xs) = powersets xs ++ (fmap (x:) $ powersets xs)

-- 가능한 모든 식 구하기
exprs :: [Int] ->  [Expr]
exprs [] = []
exprs [x] = [Val x]
exprs xs = interleave xs >>= \xs' -> split xs' >>= \(l,r) -> exprs l >>= \lval -> exprs r >>= \rval 
        -> [Add,Sub,Mul,Div] >>= \o 
          -> return (App o lval rval)

validExprs :: [Int] -> [Expr] 
validExprs xs = filter valid $ exprs xs

results :: [Int] -> Int -> [Result]
results xs n = (filter (\e -> eval e == n) $ validExprs xs) >>= \ex -> return (ex, eval ex)

valid :: Expr  -> Bool
valid (App Add l r) = (eval l + eval r) > 0
valid (App Mul l r) = (eval l * eval r) > 0
valid (App Sub l r) = eval l > eval r
valid (App Div l r) = eval r /= 0 && eval l `mod` eval r == 0
valid (Val x) = x > 0

-- needs nPr
nPr :: Eq a => [a] -> Int -> [[a]]
nPr [] _ = [[]]
nPr  _ 0 = [[]]
--nPr [3] = [[3]]
--nPr [2,3] = [[2,3],[3,2]]
--nPr [1,2,3] = [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]
--nPr [1,2,3] = [[1,2,3],[2,1,3],[2,3,1],[1,3,2],[3,1,2],[3,2,1]]
nPr ns r = ns >>= \n' -> fmap (n':) $ nPr (filter (/=n') ns ) (r-1)
-- f[1,2,3] 2 => [1,2,3] >>= 1: f[2,3] 1
--                              f[2,3] 1 => [2,3] >>= 2: f [3] 0
--                                                       f [3] 0 == [[]]
--            [1:2:[[]]] == [[1,2]] 
--            [1:3:[[]]] == [[1,3]] 
--            [2:1:[[]]] == [[2,1]] 
--            [2:3:[[]]] == [[2,3]] 
--            [3:1:[[]]] == [[3,1]] 
--            [3:2:[[]]] == [[3,2]] 
interleave :: [a] -> [[a]]
interleave [] = [[]]
interleave [x] = [[x]]
interleave (x:y:zs) = [x:y:zs] ++ (fmap (y:) $ interleave (x:zs))

