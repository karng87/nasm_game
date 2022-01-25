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

main' :: IO [()]
main' = pure [1..4] >>= mapM (\a -> putStrLn ("Which color " ++ show a ++ "?") >>=  (\x -> getLine)) >>= (\cs -> putStrLn "The color are: " >>= \_ -> mapM putStrLn cs)


