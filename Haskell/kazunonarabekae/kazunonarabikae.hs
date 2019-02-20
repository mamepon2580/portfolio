{-数の並び替え-}
import Data.List

{-main関数-}
main = do
  x <- getLine
  y <- getContents
  putStrLn (conect (map show (insertSort (strToIntList y) [])))

{-IO関数-}
strToIntList :: String -> [Int]
strToIntList x = map (\a ->read a ::Int) (lines x)

conect :: [String] -> String
conect [] = ""
conect (x:xs) = x ++ "\n" ++ conect xs

{-その他の関数-}
insert' :: Int -> [Int] -> [Int]
insert' x []              = [x]
insert' x (y:ys) | x < y  = (x:y:ys)
                 | x >= y  = [y] ++ insert' x ys

insertSort :: [Int] -> [Int] -> [Int]
insertSort [] ys     = ys
insertSort (x:xs) ys = insertSort xs (insert' x ys)
