{-文字列の比較-}
import Data.List

{-main関数-}
main = do
  x <- getLine
  y <- getLine
  putStrLn (hikaku x y)

{-IO関数-}

{-その他の関数-}
hikaku :: String -> String -> String
hikaku x y | x == y = "OK"
           | x /= y = "NG"
