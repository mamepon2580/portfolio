{-山折り谷折り-}

{-IO-}
main = do
  x <- getLine
  putStrLn (intListToString (fold (read x :: Int)))

{-IO関数-}
intListToString :: [Int] -> String
intListToString [] = []
intListToString (x:xs) = (show x) ++ (intListToString xs)

{-関数-}
reverse01 :: Int -> Int
reverse01 x | x == 0 = 1
            | x == 1 = 0

fold :: Int -> [Int]
fold 1 = [0]
fold i = fold (i - 1) ++ [0] ++ map reverse01 (reverse (fold (i - 1)))
