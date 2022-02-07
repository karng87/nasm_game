module Countdown where

main :: IO ()
main = do
  putStrLn "give me a list [Int]"
  ns <- readLn ::IO[Int]
  putStrLn "give me a Int as the result Int"
  n <- readLn
  display $ results ns n

display :: Result -> IO()
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

exprs :: [Int] -> Int -> Expr
exprs [] n = Val n
exprs _ n = App Add (Val n) (Val n)

results :: [Int] -> Int -> Result
results _ _ = (e1, eval e1)

-- ns 를 쪼개기 :: 만들수 있는 자리수 쌍 구하기
split :: [a] -> [([a],[a])]
split [] = [] -- ([],[])
split [_]= [] -- ([],[])
split (x:xs) = [([x],xs)] ++ (fmap (\(i,j)-> (x:i,j)) $ split xs)
