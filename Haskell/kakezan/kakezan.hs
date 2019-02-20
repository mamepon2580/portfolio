{-掛け算-}
import Data.List

{-main関数-}
main = do
  x <- getLine
  y <- getLine
  putStrLn (show $ seki (strToInt x) (strToInt y))

{-IO関数-}
strToInt :: String -> Int
strToInt x = (\a ->read a ::Int) x

{-その他の関数-}
seki :: Int -> Int -> Int
seki x y = x * y
