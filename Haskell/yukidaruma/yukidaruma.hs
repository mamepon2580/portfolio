{-雪だるま作り-}

import Data.List

{-main関数-}

main = do
  x <- getLine
  y <- getLine
  putStrLn (show (yuki' (readY x) (map (\x -> read x ::Int) (words y))))

{-IO関数-}
readY :: String -> Int
readY x = getY (map (\x -> read x ::Int) (words x))

getY :: [Int] -> Int
getY (x:y:[]) = y

{-その他の関数-}

insertSort :: [Int] -> [Int]
insertSort [] = []
insertSort (x:xs) = insert x (insertSort xs)

make :: Int -> Int -> [Int] -> [Int] -> Int
make n i _ []                         = i
make n i _ (z:[])                     = i
make n i (x:[]) (z:zs)                = make n i zs zs
make n i (x:y:ys) (z:zs) | x + y >= n = (\t -> make n (i + 1) t t) (delete y zs)
                         | otherwise  = make n i (x:ys) (z:zs)

yuki :: Int -> [Int] -> Int
yuki n x = make n 0 x x

yuki' :: Int -> [Int] -> Int
yuki' n x = yuki n (insertSort x)
