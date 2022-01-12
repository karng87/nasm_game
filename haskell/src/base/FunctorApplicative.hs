-------------
-- Functor --
-------------

-- fmap f x = f <$> x = pure f <*> x

----------------
-- Applcative --
----------------
-- pure = Just
-- <*>

read2line :: IO String
read2line = do
            a <- getLine
            b <- getLine
            return (a++b)

r2line = do
            a <- (++) <$> getLine <*> getLine
            putStrLn a  


