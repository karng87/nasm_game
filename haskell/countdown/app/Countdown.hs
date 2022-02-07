module Countdown where

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

-- 무효한 식을 공집합으로 받기 위해 []을 사용함
eval :: Expr -> [Int]
eval (Val n) = [n | n > 0]
eval (App o l r) = case o of 
  Add -> eval l >>= \l' -> eval r >>= \r' -> [l' + r']
  Sub -> eval l >>= \l' -> eval r >>= \r' -> if (l' > r') then [l' - r'] else []
  Mul -> eval l >>= \l' -> eval r >>= \r' -> [l' * r']
  Div -> eval l >>= \l' -> eval r >>= \r' -> if (l' `mod` r' == 0) then [l' `div` r'] else []

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
exprs xs = split xs >>= \(l,r) -> exprs l >>= \lval -> exprs r >>= \rval -> [Add,Sub,Mul,Div] >>= \o  -> return (App o lval rval)

solutions :: [Int] -> Int -> [Expr]
solutions xs n = filter (\x -> eval x == [n]) (concat . map exprs . concat . map interleave . powersets $ xs)

results :: [Int] -> Int -> [Result]
results xs x = solutions xs x >>= \expr  -> eval expr >>= \n -> [(expr, n)]

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

