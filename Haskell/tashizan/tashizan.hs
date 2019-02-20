{-掛け算-}
import Data.List

{-main関数-}
main = do
  x <- getLine
  putStrLn (show $ wa $ strToIntList x)

{-IO関数-}
strToIntList :: String -> [Int]
strToIntList x = map (\a ->read a ::Int) (words x)

{-その他の関数-}
wa :: [Int] -> Int
wa [] = 0
wa (x:xs) = x + (wa xs)
