module ForM where
import Control.Monad

main :: IO[()]
main = do
  colors <- forM [1::Int ..4] (\a -> do
    putStrLn $ "what color do you associate with the number" ++ show a ++ "?"
    getLine
    )
  putStrLn "The colors that you associate with 1,2,3 and 4 are: "
  mapM putStrLn colors

mainb :: IO[()]
mainb = do
  colors <- forM [1::Int ..4] (\a -> (putStrLn $ "what color do you associate with the number" ++ show a ++ "?")  >>= \x -> getLine)
  putStrLn "The colors that you associate with 1,2,3 and 4 are: "
  mapM putStrLn colors

mainbb :: IO[()]
mainbb = 
  forM [1::Int ..4] (\a -> (putStrLn $ "what color do you associate with the number" ++ show a ++ "?")  >>= \x -> getLine)
  >>= \cs -> putStrLn "The colors that you associate with 1,2,3 and 4 are: " >>= \_ -> mapM putStrLn cs

mainbbb :: IO[()]
mainbbb = 
  forM [1::Int ..4] (\a -> (putStrLn $ "what color do you associate with the number" ++ show a ++ "?")  >> getLine)
  >>= \cs -> putStrLn "The colors that you associate with 1,2,3 and 4 are: " >> mapM putStrLn cs
main' :: IO [()]
main' = pure [1::Int ..4] 
  >>= mapM (\a -> putStrLn ("Which color do you associate number " ++ show a ++ "?") >>=  (\x -> getLine)) 
  >>= (\cs -> putStrLn "The color are: " >>= \_ -> mapM putStrLn cs)

main'' :: IO [()]
main''= pure [1::Int ..4] 
  >>= mapM (\a -> putStrLn ("Which color do you associate with the number " ++ show a ++ "?") >> getLine) 
  >>= (\cs -> putStrLn "The color are: " >>  mapM putStrLn cs)

main''' :: IO [()]
main'''= mapM (\a -> putStrLn ("Which color do you associate with the number " ++ show a ++ "?") >> getLine) [1::Int ..4] 
  >>= (\cs -> putStrLn "The color are: " >>  mapM putStrLn cs)

