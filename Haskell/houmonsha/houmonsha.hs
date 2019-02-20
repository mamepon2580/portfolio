{-日別訪問者数の最大平均区間-}
import Data.List

{-main関数-}
main = do
  x <- getLine
  y <- getLine
  putStrLn ()

{-IO関数-}
strToInt :: String -> Int
strToInt x = (\a ->read a ::Int) x

{-その他の関数-}
sum :: [Int] -> [Int]
sum []     = []
sum (x:xs) = x + (sum xs)

abe :: [Int] -> Int
abe xs = (sum xs) / (length xs)

makeAbeList :: [Int] -> [Int]
makeAbeList []     = []
makeAbeList (x:xs) = [abe (x:xs)] ++ (makeAbeList xs)

maxListNum :: Int -> Int -> Int -> [Int] -> Int
maxListNum m n l []              =  l
maxListNum m n l (x:xs) | x > l  = maxListNum (m + 1) m x (maxListNum xs)
                        | x <= l = maxListNum (m + 1) n l (maxListNum xs)

sameValue :: Int -> Float -> [Float] -> Int
sameValue n x []              = n
sameValue n x (y:ys) | x == y = sameValue (n + 1) x ys
                     | x /= y = sameValue n x ys
